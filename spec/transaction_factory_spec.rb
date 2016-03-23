require 'spec_helper'

describe TransactionFactory do
  describe "::create" do
    it "creates a deposit" do
      amount = 100
      date = "10-01-2012"
      expect(TransactionFactory.create(:deposit, amount, date).class)
        .to eq(DepositTransaction)
    end

    it "creates a withdrawal" do
      amount = 100
      date = "10-01-2012"
      expect(TransactionFactory.create(:withdrawal, amount, date).class)
        .to eq(WithdrawalTransaction)
    end

    it "cannot create a transaction of an unknown type" do
      expect { TransactionFactory.create(:hell_no, 100, "10-01-2012") }
        .to raise_error(ArgumentError)
    end
  end

  describe "::is_transaction?" do
    it "returns true for 'deposit'" do
      expect(TransactionFactory.is_transaction?("deposit")).to eq(true)
    end

    it "returns true for 'withdrawal'" do
      expect(TransactionFactory.is_transaction?("withdrawal")).to eq(true)
    end

    it "returns false for 'somethingelse'" do
      expect(TransactionFactory.is_transaction?("somethingelse")).to eq(false)
    end
  end
end
