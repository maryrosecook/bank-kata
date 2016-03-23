require 'spec_helper'

describe WithdrawalTransaction do
  describe "::new" do
    it "creates a withdrawal with amount and string date" do
      amount = 100
      date_str = "10-01-2012"
      withdrawal = WithdrawalTransaction.new(amount, date_str)
      expect(withdrawal.amount).to eq(-amount)
      expect(withdrawal.date).to eq(Date.parse(date_str))
    end
  end

  describe "#credit" do
    it "returns nil" do
      expect(WithdrawalTransaction.new(100, "10-01-2012").credit).to eq(nil)
    end
  end

  describe "#debit" do
    it "returns amount" do
      amount = 100
      expect(WithdrawalTransaction.new(amount, "10-01-2012").debit).to eq(-amount)
    end
  end
end
