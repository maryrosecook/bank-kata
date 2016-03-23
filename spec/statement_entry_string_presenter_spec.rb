require 'spec_helper'

describe StatementEntryStringPresenter do
  describe "#date" do
    it "returns the date in dd/mm/yyyy format" do
      statement_entry = double(date: Date.parse("10-10-2012"))
      date = StatementEntryStringPresenter.new(statement_entry).date
      expect(date).to eq("10/10/2012")
    end

  end

  describe "#credit" do
    it "returns credit as string with two decimal places if credit exists on the entry" do
      statement_entry = double(credit: 100)
      credit = StatementEntryStringPresenter.new(statement_entry).credit
      expect(credit).to eq("100.00")
    end

    it "returns credit as an empty string if credit doesn't exist on the entry" do
      statement_entry = double(credit: nil)
      credit = StatementEntryStringPresenter.new(statement_entry).credit
      expect(credit).to eq("")
    end
  end

  describe "#debit" do
    it "returns debit as string with two decimal places if debit exists on the entry" do
      statement_entry = double(debit: 100)
      debit = StatementEntryStringPresenter.new(statement_entry).debit
      expect(debit).to eq("100.00")
    end

    it "returns debit as an empty string if debit doesn't exist on the entry" do
      statement_entry = double(debit: nil)
      debit = StatementEntryStringPresenter.new(statement_entry).debit
      expect(debit).to eq("")
    end
  end

  describe "#balance" do
    it "returns balance as string with two decimal places" do
      statement_entry = double(balance: 100)
      balance = StatementEntryStringPresenter.new(statement_entry).balance
      expect(balance).to eq("100.00")
    end
  end
end
