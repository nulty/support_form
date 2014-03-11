require 'spec_helper'

describe "Submitting the support Modal" do
  before do
    @page = Page.create
    @stats = @page.create_support_stats(categories: {"cat_1" => 0, "cat_2" => 0}, "recipient_email"=>"e@e.com")
  end

  describe "successful support request" do

    context "Flash Notice enabled" do

      it "submits form with the flash message", js: true do
        visit page_path(@page)

        expect(page).to have_selector("div.modal-body", :visible=>false)

        find("a", :text=>"Support").click

        expect(page).to have_selector("div.modal-body", :visible=>true)

        within find("#new_support_form_enquiry") do
          fill_in_form
        end

        expect{
          find("a", :text=>"Submit Support Request").click
        }.to change{ SupportForm::Stat.last.reload.categories["cat_1"] }.by(1)

        find(".flash-notice", visible: true, text: "Your support query has been received")
        find(".flash-notice", visible: false, text: "")

        expect(page).to have_selector("div.modal-body", :visible=>false, wait: 3)

        [".modal-body #support_form_enquiry_message", ".modal-body #support_form_enquiry_topic",
            ".modal-body #support_form_enquiry_email", ".modal-body #support_form_enquiry_name"].each do |input|
              expect(find(input).value).to eq ""
            end

        find("div.flash-notice", visible: false)
      end
    end

    context "Flash Notice disabled" do
      before { SupportForm.configuration.use_form_flash = false }
      after  { SupportForm.configuration.use_form_flash = true }

      it "submits form with no the flash message", js: true do
        visit page_path(@page)
        find("a", :text=>"Support").click
        within find("#new_support_form_enquiry") do
          fill_in_form
        end
        find("a", :text=>"Submit Support Request").click
        expect(page).not_to have_selector(".flash-notice", visible: false, text: "Your support query has been received")
      end
    end
  end

  context "support request with errors" do

    it "creates a new form", js: true do
      visit page_path(@page)
      find("a", :text=>"Support").click

      within find("#new_support_form_enquiry") do
        fill_in "support_form_enquiry_email", with: "Email"
        fill_in "support_form_enquiry_message", with: "Message"
      end
      click_link "Submit Support Request"

      expect(page).to have_content("Topic can't be blank", "Name can't be blank")

      within find("#new_support_form_enquiry") do
        select "cat_1"
        fill_in "support_form_enquiry_name", with: "Name"
      end

      expect{
        click_link "Submit Support Request"
      }.to change{ SupportForm::Stat.last.reload.categories["cat_1"] }.by(1)

      expect(page).not_to have_content("Topic can't be blank", "Name can't be blank")
      find(".flash-notice", visible: false, text: "Your support query has been received")

      expect(page).to have_selector("div.modal-body", :visible=>false, wait: 3)

      [".modal-body #support_form_enquiry_message", ".modal-body #support_form_enquiry_topic",
          ".modal-body #support_form_enquiry_email", ".modal-body #support_form_enquiry_name"].each do |input|
            expect(find(input).value).to eq ""
          end
    end
  end
end