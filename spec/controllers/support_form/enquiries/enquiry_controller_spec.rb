require 'spec_helper'

describe SupportForm::EnquiriesController do

  before(:each) do
    @page = Page.create
    @stats = @page.create_support_stats(categories: {"category_1" => 0}, recipient_email: "iain@picturk.com")
    @enquiry_params = {"support_form_enquiry" => {name: "Name", email: "email@email.com", message: "Some Message", stats_id: @stats.id, topic: "category_1"}}
    @invalid_params = {"support_form_enquiry" => {name: "", email: "email@email.com", message: "Some Message", stats_id: @stats.id, topic: "category_1"}}
  end

  describe "Creating a new enquiry" do

    describe "with valid parameters" do
      context "without referrer" do
        it "redirects to root_path" do
          post :create, @enquiry_params
          expect(response).to redirect_to(root_path)
        end

        it "updates the stats" do
          expect{
            post :create, @enquiry_params
            }.to change{@stats.reload.categories["category_1"].to_i}.by(1)
        end
      end

      context "with referrer" do

        before { request.env["HTTP_REFERER"] = root_path }

        it "redirects to referrer" do
          post :create, @enquiry_params
          expect(response).to redirect_to(request.env["HTTP_REFERER"])
        end

        it "updates the stats" do
          expect{
            post :create, @enquiry_params
            }.to change{@stats.reload.categories["category_1"].to_i}.by(1)
        end
      end
    end

    describe "with invalid parameters" do

      context "without referrer" do
        render_views

        it "renders the new action" do
          post :create, @invalid_params
          expect(response).to have_rendered :new
          expect(response.body).to have_content "blank"
        end

        it "does not update the stats" do
          expect{
            post :create, @invalid_params
            }.not_to change{@stats.reload.categories["category_1"].to_i}
        end

      end

      context "with referrer" do

        before { request.env["HTTP_REFERER"] = root_path }

        it "redirects to referrer" do
          post :create, @invalid_params
          expect(response).to redirect_to(request.env["HTTP_REFERER"])
        end

        it "does not update the stats" do
          expect{
            post :create, @invalid_params
            }.not_to change{@stats.reload.categories["category_1"].to_i}
        end

      end
    end
  end
end
