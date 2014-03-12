<% if @result %>
  $('#support-form').html("<%= escape_javascript(render('support_form/enquiries/form'))%>")
    $('#support_form_enquiry_message, #support_form_enquiry_name, #support_form_enquiry_topic, #support_form_enquiry_email').each(function(idx,ele) {
    $(ele).val("");
  })
<% else %>
  $('#support-form').html("<%= escape_javascript(render('support_form/enquiries/form'))%>")
<% end %>