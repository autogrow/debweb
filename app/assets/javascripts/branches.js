

$().ready(function() {

  select = $("#debfile_ids_")
  select.val('');

  select.select2({
    theme: "bootstrap",
    placeholder: "Search packages, push enter to add",
    allowClear: true
  }).on("select2:select", function() {
    $(this).parents('form').submit();
  });

  select.select2("val", "");

});