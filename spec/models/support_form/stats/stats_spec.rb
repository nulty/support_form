require 'spec_helper'

describe SupportForm::Stat do
  before(:all) do
    @valid_parameters       = {"sender_email" => "email@email.com", "recipient_email" => "email@picturk.com","categories" => {"cat_1" => "1", "cat_2" => "2"}}
    @one_category           = {"categories"=>{"cat_1" => "1"}}
    @two_recipient_emails   = {"recipient_email" => "email@picturk.com, second@picturk.com"}
    @invalid_two_recipients = {"recipient_email" => "email, second@picturk.com"}
  end

  describe "invalid sender email" do
    subject { SupportForm::Stat.new(@valid_parameters.merge({"sender_email" => "emailemail.com"})) }
    it { expect(subject).to be_invalid }
  end

  describe "valid recipient email" do
    context "one email address" do
      subject { SupportForm::Stat.new(@valid_parameters) }
      it { expect(subject).to be_valid }
    end

    context "two emails addresses" do
      subject { SupportForm::Stat.new(@valid_parameters.merge(@two_recipient_emails)) }
      it { expect(subject).to be_valid }
    end
  end

  describe "invalid recipient email" do
    context "one email address" do
      subject { SupportForm::Stat.new(@valid_parameters.merge({recipient_email: "email"})) }
      it { expect(subject).to be_invalid }
    end

    context "two emails addresses" do
      subject { SupportForm::Stat.new(@valid_parameters.merge(@invalid_two_recipients)) }
      it { expect(subject).to be_invalid }
    end
  end

  describe "one category in stats hash" do
    subject { SupportForm::Stat.new(@valid_parameters.merge(@one_category)) }
    it { expect(subject).to be_valid }
  end

  describe "two category in stats hash" do
    subject { SupportForm::Stat.new(@valid_parameters) }
    it { expect(subject).to be_valid }
  end

end
