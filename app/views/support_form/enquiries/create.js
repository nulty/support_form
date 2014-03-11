
<% if @result %>
  $('.modal-body').html("<%= escape_javascript(support_form) %>");
  $('.flash-notice').show()
  setTimeout(function(){
    setTimeout(function(){
      $('#support-modal').modal('hide');
    }, 1000);
  $('.flash-notice').empty()
  }, 2000);

  // reset the fields
  $('.modal-body #support_form_enquiry_topic, .modal-body #support_form_enquiry_name, .modal-body #support_form_enquiry_email, .modal-body #support_form_enquiry_message').each(function(idx,e){
    $(e).val("");
  })
<% else %>
  $('.modal-body').html("<%= escape_javascript(support_form) %>");
<% end %>
