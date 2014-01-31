require 'spec_helper'

describe "Support form" do
  it "renders on the page" do
    visit "/"
    expect(page).to have_selector("form")
  end
end