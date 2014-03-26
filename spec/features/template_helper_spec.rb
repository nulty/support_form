require 'spec_helper'

describe "Support form" do
  before(:each) do
    @page = Page.create
    @stat = @page.create_support_stats({"recipient_email" => "email@picturk.com","categories" => {"cat_1" => "1", "cat_2" => "2"}})
  end

  it "submits form and shows the flash message", js: true do
    visit page_path(@page)
    expect(page).to have_selector("select option", text: "cat_1")
    fill_in_form
    expect{
      find("input[type=submit]").click
      sleep 1
    }.to change{ ActionMailer::Base.deliveries.count}.by(1)

    expect(page).to have_content "Your support query has been received"
  end

  describe "form for current_user" do

    context "current_user" do
      it "form is prepopulated the form with user details" do
        $LOGGEDIN = true
        visit page_path(@page)
        expect(find("#support_form_enquiry_name").value).to eq("Joe Bloggs")
        expect(find("#support_form_enquiry_email").value).to eq("joe@email.com")
      end
    end

    context "no current_user" do
      it "form is blank" do
        $LOGGEDIN = false
        visit page_path(@page)
        expect(find("#support_form_enquiry_name").value).to be_nil
        expect(find("#support_form_enquiry_email").value).to be_nil
      end
    end
  end
end
