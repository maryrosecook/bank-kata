require 'spec_helper'

describe StatementStringPrinter do
  describe "::to_string" do
    it "prints only header when statement is empty" do
      str = StatementStringPrinter.to_string(Statement.new([]))
      expect(str).to eq("date || credit || debit || balance")
    end

    it "should take two deposits and a withdrawal and print a statement" do
      account = Account.new([])
      account.add_transaction(DepositTransaction.new(1000, "10-01-2012"))
      account.add_transaction(DepositTransaction.new(2000, "13-01-2012"))
      account.add_transaction(WithdrawalTransaction.new(500, "14-01-2012"))

      str = StatementStringPrinter.to_string(account.statement)

      expect(str).to eq("date || credit || debit || balance\n\n"\
                        "14/01/2012 ||  || 500.00 || 2500.00\n\n"\
                        "13/01/2012 || 2000.00 ||  || 3000.00\n\n"\
                        "10/01/2012 || 1000.00 ||  || 1000.00")
    end
  end
end
