require 'spec_helper'

describe SupportForm::Enquiry do

  describe "invalid parameters" do
    subject{ SupportForm::Enquiry.new }
    it { expect(subject).not_to be_valid }
  end
end
