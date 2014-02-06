require 'spec_helper'

describe "Support form" do
  before(:all) do
    SupportForm::Stat.create({"recipient_email" => "email@picturk.com","stats" => {"cat_1" => "1", "cat_2" => "2"}})
  end
  it "renders on the page" do
    visit root_path
    expect(page).to have_selector("form")
  end

  it "has a dropdown box on the page" do
    visit root_path
    expect(page).to have_selector("select")
    expect(page).to have_content("cat_1", "cat_2")
  end
end