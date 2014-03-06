require 'spec_helper'

describe "Support form" do
  before(:each) do
    @page = Page.create
    @stat = @page.create_support_stats({"recipient_email" => "email@picturk.com","categories" => {"cat_1" => "1", "cat_2" => "2"}})
  end

  it "submits form and shows the flash message" do
    visit page_path(@page)
    expect(page).to have_content("cat_1", "cat_2")
    fill_in_form
    expect{
      find("input[type=submit]").click
    }.to change{ ActionMailer::Base.deliveries.count}.by(1)

    expect(page).to have_content "Your support query has been received"
  end
end
