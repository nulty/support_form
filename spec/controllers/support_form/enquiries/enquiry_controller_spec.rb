require 'spec_helper'

describe SupportForm::EnquiriesController do

  before(:each) do
    @stats = SupportForm::Stat.create(stats: {"category_1" => "4"}, recipient_email: "iain@picturk.com")
    @enquiry_params = {"support_form_enquiry" => {name: "Name", email: "email@email.com", message: "Some Message", stats_id: @stats.id, topic: "category_1"}}
  end

  describe "Creating a new enquiry" do

    it "receives the parameters" do
      post :create, @enquiry_params
      expect(response).to redirect_to(root_path)
    end

    it "updates the stats" do
      expect{
        post :create, @enquiry_params
        }.to change{@stats.reload.stats["category_1"].to_i}.by(1)
    end
  end
end
