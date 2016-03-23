require 'spec_helper'

describe Statement do
  describe "::new" do
    it "creates a statement" do
      expect(Statement.new([]).class).to eq(Statement)
    end
  end

  describe "#statement_entries" do
    it "generates an entry for a deposit" do
      date_str = "10-01-2012"
      amount = 100
      transaction_list = []
      transaction_list << DepositTransaction.new(amount, date_str)

      entry = Statement.new(transaction_list).statement_entries.first
      expect(entry.date).to eq(Date.parse(date_str))
      expect(entry.credit).to eq(amount)
      expect(entry.debit).to eq(nil)
      expect(entry.balance).to eq(amount)
    end

    it "generates an entry for a withdrawal" do
      date_str = "10-01-2012"
      amount = 100
      transaction_list = []
      transaction_list << WithdrawalTransaction.new(amount, date_str)

      entry = Statement.new(transaction_list).statement_entries.first
      expect(entry.date).to eq(Date.parse(date_str))
      expect(entry.debit).to eq(-amount)
      expect(entry.credit).to eq(nil)
      expect(entry.balance).to eq(-amount)
    end

    it "sorts entries in descending order of date" do
      transaction_list = [WithdrawalTransaction.new(100, "12-01-2012"),
                          WithdrawalTransaction.new(100, "11-01-2012"),
                          WithdrawalTransaction.new(100, "10-01-2012")]

      entries = Statement.new(transaction_list).statement_entries
      expect(entries[0].date).to eq(Date.parse("12-01-2012"))
      expect(entries[1].date).to eq(Date.parse("11-01-2012"))
      expect(entries[2].date).to eq(Date.parse("10-01-2012"))
    end

    it "sets entry balances to the total up to and including entry's date" do
      transaction_list = [WithdrawalTransaction.new(100, "12-01-2012"),
                          WithdrawalTransaction.new(100, "11-01-2012"),
                          WithdrawalTransaction.new(100, "10-01-2012")]

      entries = Statement.new(transaction_list).statement_entries

      expect(entries[0].date).to eq(Date.parse("12-01-2012"))
      expect(entries[0].balance).to eq(-300)

      expect(entries[1].date).to eq(Date.parse("11-01-2012"))
      expect(entries[1].balance).to eq(-200)

      expect(entries[2].date).to eq(Date.parse("10-01-2012"))
      expect(entries[2].balance).to eq(-100)
    end
  end
end
