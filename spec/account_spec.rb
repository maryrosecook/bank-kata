require 'spec_helper'

describe Account do
  describe "::new" do
    it "creates a new account" do
      expect(Account.new([]).class).to eq(Account)
    end
  end

  describe "#add_transaction" do
    it "adds a deposit with a date and amount" do
      deposit = {}

      transaction_list = []
      expect(transaction_list).to receive(:<<).with(deposit)

      account = Account.new(transaction_list)
      account.add_transaction(deposit)
    end
  end

  describe "#statement" do
    it "returns a statement" do
      transaction_list = []
      account = Account.new(transaction_list)

      expect(Statement).to receive(:new).with(transaction_list) {
        "statement"
      }

      expect(account.statement).to eq("statement")
    end
  end
end
