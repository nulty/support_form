require "spec_helper"

describe "Creating a new support form" do

  it "creates a new form", js: true do
    visit support_form_stats_path
    click_link "New Support Form"
    expect(page).to have_selector("input[name^=support_form_stat\\[categories\\]]")
    expect{
      click_link("add_category")
      }.to change{ all("input[type=text]").count }.by(1)
    fill_in "support_form_stat_categories", with: "Payment"
    fill_in "support_form_stat_categories_1", with: "Replacing wrong image"
    fill_in "support_form_stat_recipient_email", with: "email@picturk.com"
    expect{
      find("[value='Create Categories']").click
      expect(page).to have_content ""
    }.to change{ SupportForm::Stat.count }.by(1)
    expect(current_path).to eq(root_path)
  end

  describe "Editing a Support Form", js: true do
    before(:each) do
      @support_form_stats = SupportForm::Stat.create(categories: {"Q1" => 0, "Q2" => 0}, "recipient_email"=>"e@e.com")
    end

    it "edits and update form categories", js: true do
      visit edit_support_form_stat_path(@support_form_stats)
      expect(page).to have_selector "[value=Q1]"
      find_field("support_form_stat_categories_0").set("A1")
      expect{
        click_button "Edit Categories"
        expect(page).to have_content ""
      }.to change{ @support_form_stats.reload.categories.first.first }.to("A1")
      expect(current_path).to eq(support_form_stats_path)
    end
  end
end