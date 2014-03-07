require 'spec_helper'

describe EmailListValidator do
  let(:stats) { double("stat") }
  subject { EmailListValidator.new({}) }

  before(:each) do
    stats.stub(:errors).and_return(ActiveModel::Errors.new({}))
  end

  describe "One valid email" do
    before { stats.stub(:recipient_email).and_return("email@email.com") }
    it "is valid" do
      subject.validate(stats)
      expect(stats.errors).to be_empty
    end

  end

  describe "One invalid emails" do
    before { stats.stub(:recipient_email).and_return("@email.com") }
    it "is invalid" do
      subject.validate(stats)
      expect(stats.errors.messages[:base]).to include("The format of your recipients_emails is invalid")
    end
  end

  describe "Two valid emails" do
    before { stats.stub(:recipient_email).and_return("email@email.com, real@email.net") }
    it "is invalid" do
      subject.validate(stats)
      expect(stats.errors).to be_empty
    end
  end

  describe "Two invalid emails" do
    before { stats.stub(:recipient_email).and_return("email@email, email.net") }
    it "is invalid" do
      subject.validate(stats)
      expect(stats.errors.messages[:base]).to include("The format of your recipients_emails is invalid")
    end
  end

  describe "Two Valid, One invalid emails" do
    before { stats.stub(:recipient_email).and_return("email@email.com, real@email.net, email.net") }
    it "is invalid" do
      subject.validate(stats)
      expect(stats.errors.messages[:base]).to include("The format of your recipients_emails is invalid")
    end
  end

  describe "wrong separator" do
    before { stats.stub(:recipient_email).and_return("email@email.com. real@email.net") }
    it "is invalid" do
      subject.validate(stats)
      expect(stats.errors.messages[:base]).to include("The format of your recipients_emails is invalid")
    end
  end
end