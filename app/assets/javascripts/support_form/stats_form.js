$(document).ready(function() {
  var count = $("[class=category_name]").length

  name_name = $('[class=category_name]').first().attr("name")
  val_name = $('[class=category_value]').first().attr("name")
  name_id = $('[class=category_name]').first().attr("id")
  val_id = $('[class=category_value]').first().attr("id")
  count = $("[class=category_name]").length

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

})