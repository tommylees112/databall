$(document).ready(function() {
  $(".dashboard-tab").click(function(e) {
    e.preventDefault();
    $(".message").removeClass("active");
    $($(this).data("target")).addClass("active");
  })
  $(".dashboard-tab.all").click(function(e) {
    e.preventDefault();
    $(".message").addClass("active");
  })
})
