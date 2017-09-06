$(document).ready(function() {
  $(".dashboard-tab").click(function(e) {
    e.preventDefault();
    $(".message").removeClass("active");
    $($(this).data("target")).addClass("active");
  })
  $("#all").click(function() {
    $(".message").addClass("active");
  })
})
