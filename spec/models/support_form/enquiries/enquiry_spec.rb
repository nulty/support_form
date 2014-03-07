require 'spec_helper'

describe SupportForm::Enquiry do

  before(:each) do
    stats = SupportForm::Stat.create(categories: {"cat_1"=>4, "cat_2"=>5}, recipient_email:"some@email.com", sender_email:"other@email.com")
    @valid_parameters = {name: "a", email: "a@a.com", message: "a", stats_id: String(stats.id), topic: "cat_2"}
  end


  describe "valid parameters" do
    subject{ SupportForm::Enquiry.new(@valid_parameters) }
    it { expect(subject).to be_valid }
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

    describe "topic not included" do
      subject{ SupportForm::Enquiry.new(@valid_parameters.merge({topic: "false"})) }
      it { expect(subject).to be_invalid }
    end
  end
end
