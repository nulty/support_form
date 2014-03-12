require 'spec_helper'

describe SupportForm::EnquiriesController do

  before(:each) do
    @page = Page.create
    @stats = @page.create_support_stats(categories: {"category_1" => 0}, recipient_email: "iain@picturk.com")
    @enquiry_params = {"support_form_enquiry" => {first_name: "", name: "Name", email: "email@email.com", message: "Some Message", stats_id: String(@stats.id), topic: "category_1", event: "Some Title"}}
    @invalid_params = {"support_form_enquiry" => {first_name: "", name: "", email: "email@email.com", message: "Some Message", stats_id: String(@stats.id), topic: "category_1", event: "Some Title"}}
    @spam_params = {"support_form_enquiry" => {first_name: "spam", name: "name", email: "email@email.com", message: "Some Message", stats_id: String(@stats.id), topic: "category_1", event: "Some Title"}}
  end

  describe "Creating a new enquiry" do

    describe "with valid parameters" do
      context "without referrer" do
        it "redirects to root_path" do
          xhr :post, :create, @enquiry_params
          expect(response).to render_template(:create)
        end

        it "updates the stats" do
          expect{
            xhr :post, :create, @enquiry_params
            }.to change{@stats.reload.categories["category_1"].to_i}.by(1)
        end
      end
    end

    describe "with invalid parameters" do

      render_views

      it "renders the new action" do
        xhr :post, :create, @invalid_params
        expect(response).to have_rendered :create
      end

      it "does not update the stats" do
        expect{
          xhr :post, :create, @invalid_params
          }.not_to change{@stats.reload.categories["category_1"].to_i}
      end
    end

    describe "with spam parameters" do

      render_views

      it "redirects to root_path" do
        xhr :post, :create, @spam_params
        expect(response).to have_rendered :create
      end

      it "does not update the stats" do
        expect{
          xhr :post, :create, @spam_params
          }.not_to change{@stats.reload.categories["category_1"].to_i}
      end

    end
  end
end
