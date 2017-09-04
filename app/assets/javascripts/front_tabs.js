$(document).ready(function() {
  $(".odds-toggle span").click(function(){
    // e.preventDefault();
    $(".new_match").toggleClass("active");
  })



    var league = window.location.search.slice(8).replace("%20", "");
    if (window.location.search === "") {
      $(".topfive").addClass("active");
    }
    $("#" + league).addClass("active");


});
