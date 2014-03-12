$(document).ready(function() {
  var count = $("[class=category_name]").length

  name_name = $('[class=category_name]').first().attr("name")
  val_name = $('[class=category_value]').first().attr("name")
  name_id = $('[class=category_name]').first().attr("id")
  val_id = $('[class=category_value]').first().attr("id")
  count = $("[class=category_name]").length
  form = "<div id='support-form'><table> \
      <tbody><tr> \
        <td> \
        <input class='category_name' id='international_salon_salon_competition_support_stats_attributes_categories_0' name='international_salon_salon_competition[support_stats_attributes][categories][0]' size='30' type='text' value=''></td> \
        <td><input class='category_value' id='international_salon_salon_competition_support_stats_attributes_category_value_0' name='international_salon_salon_competition[support_stats_attributes][category_value][0]' size='4' type='text' value='0'></td> \
        <td><a href='#' class='delete_category'>Delete</a></td> \
    </tr></tbody></table> \
      <div> \
          <a href='#' id='add_category'>Add a Category</a>  </div>  <div class='control-group'> \
        <label for='international_salon_salon_competition_support_stats_attributes_recipient_email'>Recipient email</label> \
    <input id='international_salon_salon_competition_support_stats_attributes_recipient_email' name='international_salon_salon_competition[support_stats_attributes][recipient_email]' size='30' type='email'> \
        </div> \
        <div class='control-group'> \
    <label for='international_salon_salon_competition_support_stats_attributes_sender_email'>Sender Email - Leave blank for default mailer address</label> \
    <input id='international_salon_salon_competition_support_stats_attributes_sender_email' name='international_salon_salon_competition[support_stats_attributes][sender_email]' size='30' type='email'> \
  </div> \
  </div>"



  $("[class=category_name]").each(function(idx,ele){
    $(this).attr("name", name_name + "["+idx+"]");
    $(this).attr("id", name_id +"_" + idx);
  })
  $("[class=category_value]").each(function(idx,ele){
    $(this).attr("name", val_name + "["+idx+"]");
    $(this).attr("id", val_id +"_" + idx);
  })

  $('#add_category').click(function(e) {
    e.preventDefault();

    $("[class=category_name]").each(function(idx,ele){
      $(this).attr("name", name_name + "["+idx+"]");
      $(this).attr("id", name_id +"_" + idx);
    })
    $("[class=category_value]").each(function(idx,ele){
      $(this).attr("name", val_name + "["+idx+"]");
      $(this).attr("id", val_id +"_" + idx);
    })
    count++;

    n = count - 1

    $(this).parent().prev('table').children().append("<tr><td><input class='category_name' id='"+name_id+"_"+n+"' name='"+name_name+"["+ n +"]' size='30' type='text'></td> <td><input id='"+val_id+"_"+n+"' name='"+val_name+"["+n+"]' size='30' type='text' value='0'></td> <td><a href='#' class='delete_category'>Delete</a></td></tr>")
  })

  $('.delete_category').live('click', function(e){
    e.preventDefault();
    count = $("[class=category_name]").length
    $(this).parents("tr").remove();
  })

  $('#no-support a').click(function(e) {
    e.preventDefault();
    $('div#support-form').empty();
    $('#create-support').toggle();
    $(this).toggle();
  })

  $('#create-support').click(function(e) {
    e.preventDefault();
    $('div#support-form').html(form);
    $('div#no-support a').toggle();
    $(this).toggle();
  })
})