require 'spec_helper'

describe DepositTransaction do
  describe "::new" do
    it "creates a deposit with an amount and date string" do
      amount = 100
      date_str = "10-01-2012"
      deposit = DepositTransaction.new(amount, date_str)
      expect(deposit.amount).to eq(amount)
      expect(deposit.date).to eq(Date.parse(date_str))
    end
  end

  describe "#credit" do
    it "returns amount" do
      amount = 100
      expect(DepositTransaction.new(amount, "10-01-2012").credit).to eq(amount)
    end
  end

  describe "#debit" do
    it "returns nil" do
      expect(DepositTransaction.new(100, "10-01-2012").debit).to eq(nil)
    end
  end
end
