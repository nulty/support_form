require 'spec_helper'

describe CategoryCountValidator do
  let(:stats) { double("stat") }
  subject { CategoryCountValidator.new({}) }

  before(:each) do
    stats.stub(:errors).and_return(ActiveModel::Errors.new({}))
  end

  describe "Numeric Zero" do
    before { stats.stub(:categories).and_return({"cat_2"=>0}) }
    it "is valid" do
      subject.validate(stats)
      expect(stats.errors).to be_empty
    end

  end

  describe "Numeric five" do
    before { stats.stub(:categories).and_return({"cat_2"=>"0"}) }
    it "is valid" do
      subject.validate(stats)
      expect(stats.errors).to be_empty
    end
  end

  describe "Count is non-numeric" do
    before { stats.stub(:categories).and_return({"cat_2"=>"alert('javascript')"}) }
    it "is invalid" do
      subject.validate(stats)
      expect(stats.errors.messages[:base]).to include("Category Count for cat_2 is invalid")
    end
  end
end