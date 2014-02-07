require 'spec_helper'

describe "Support form" do
  before(:each) do
    SupportForm::Stat.create({"recipient_email" => "email@picturk.com","stats" => {"cat_1" => "1", "cat_2" => "2"}})
  end

  it "submits form and shows the flash message" do
    visit root_path
    expect(page).to have_content("cat_1", "cat_2")
    fill_in_form
    find("input[type=submit]").click
    expect(page).to have_content "Your support query has been received"
  end
end
