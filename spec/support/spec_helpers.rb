def fill_in_form
  select "cat_1"
  fill_in "support_form_enquiry_name", with: "Liam"
  fill_in "support_form_enquiry_email", with: "email@picturk.com"
  fill_in "support_form_enquiry_message", with: "Replacing wrong image"
end
