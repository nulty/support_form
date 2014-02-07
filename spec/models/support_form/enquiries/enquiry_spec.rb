require 'spec_helper'

describe SupportForm::Enquiry do

  before(:all) do
    @valid_parameters = {name: "a", email: "a@a.com", message: "a", stats_id: 1, topic: "First"}
  end

  describe "invalid with" do

    describe "blank name" do
      subject{ SupportForm::Enquiry.new(@valid_parameters.merge({name: ""})) }
      it { expect(subject).to be_invalid }
    end

    describe "blank email" do
      subject{ SupportForm::Enquiry.new(@valid_parameters.merge({email: ""})) }
      it { expect(subject).to be_invalid }
    end

    describe "blank message" do
      subject{ SupportForm::Enquiry.new(@valid_parameters.merge({message: ""})) }
      it { expect(subject).to be_invalid }
    end

    describe "blank stats_id" do
      subject{ SupportForm::Enquiry.new(@valid_parameters.merge({stats_id: ""})) }
      it { expect(subject).to be_invalid }
    end

    describe "blank topic" do
      subject{ SupportForm::Enquiry.new(@valid_parameters.merge({topic: ""})) }
      it { expect(subject).to be_invalid }
    end
  end

  describe "valid parameters" do
    subject{ SupportForm::Enquiry.new(@valid_parameters) }
    it { expect(subject).to be_valid }
  end
end
