require 'delegate'

module Bank
  class Account
    private

    attr_reader :transaction_list

    public

    def initialize(transaction_list)
      @transaction_list = transaction_list
    end

    def add_transaction(transaction)
      transaction_list << transaction
    end

    def statement
      Statement.new(transaction_list)
    end
  end

  class Statement
    private

    attr_reader :transaction_list

    public

    def initialize(transaction_list)
      @transaction_list = transaction_list
    end

    def statement_entries
      sort_descending_date
        .map { |t|
          StatementEntry.new(t.date, t.credit, t.debit, balance_to_date(t.date))
        }
    end

    private

    StatementEntry = Struct.new(:date, :credit, :debit, :balance)

    def sort_descending_date
      transaction_list.sort { |t1, t2| t2.date <=> t1.date }
    end

    def balance_to_date(date)
      transaction_list
        .select { |t| t.date <= date }
        .map { |t| t.amount }
        .inject(0, :+)
    end
  end

  class StatementEntryStringPresenter < SimpleDelegator
    def date
      statement_entry.date.strftime("%d/%m/%Y")
    end

    def credit
      statement_entry.credit ? '%.2f' % statement_entry.credit : ""
    end

    def debit
      statement_entry.debit ? '%.2f' % statement_entry.debit.abs : ""
    end

    def balance
      '%.2f' % statement_entry.balance
    end

    def statement_entry
      __getobj__
    end
  end

  module StatementStringPrinter
    def self.to_string(statement)
      [header]
        .concat(statement_entries_to_strings(statement.statement_entries))
        .join("\n\n")
    end

    private

    def self.statement_entries_to_strings(statement_entries)
      statement_entries.map { |statement_entry|
        pr = StatementEntryStringPresenter.new(statement_entry)
        "#{pr.date} || #{pr.credit} || #{pr.debit} || #{pr.balance}"
      }
    end

    def self.header
      "date || credit || debit || balance"
    end
  end

  class DepositTransaction
    attr_reader :amount, :date

    def initialize(amount, date)
      @amount = amount
      @date = DateTime.parse(date)
    end

    def credit
      amount
    end

    def debit
      nil
    end
  end

  class WithdrawalTransaction
    attr_reader :amount, :date

    def initialize(amount, date)
      @amount = -amount
      @date = DateTime.parse(date)
    end

    def credit
      nil
    end

    def debit
      amount
    end
  end

  class TransactionFactory
    def self.create(type, amount, date)
      if is_transaction?(type)
        get_transaction_class(type).new(amount, date)
      else
        raise(ArgumentError, "Not a valid transaction type")
      end
    end

    def self.is_transaction?(type)
      not get_transaction_class(type.to_sym).nil?
    end

    private

    def self.get_transaction_class(type)
      { deposit: DepositTransaction,
        withdrawal: WithdrawalTransaction }[type]
    end
  end
end
