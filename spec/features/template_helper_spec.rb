require 'spec_helper'

describe "Support form on page" do
  before(:each) do
    @page = Page.create
    @stat = @page.create_support_stats({"recipient_email" => "email@picturk.com","categories" => {"cat_1" => "1", "cat_2" => "2"}})
  end

  context "Flash Notice enabled" do
    it "submits form and the flash message",js: true do
      visit support_form_path(@page)
      expect(page).to have_content("cat_1", "cat_2")
      fill_in_form
      expect{
        find("input[type=submit]").click
      }.to change{ ActionMailer::Base.deliveries.count}.by(1)

      expect(page).to have_content "Your support query has been received"
      find("input[type='submit']", visible: true)
    end
  end

  context "Flash Notice disabled" do
    it "submits form with no flash message",js: true do
      visit support_form_path(@page)
      expect(page).to have_content("cat_1", "cat_2")
      fill_in_form
      expect{
        find("input[type=submit]").click
      }.to change{ ActionMailer::Base.deliveries.count}.by(1)

      expect(page).to have_content "Your support query has been received"
    end
  end
end
