$(document).ready(function() {
  $(".dashboard-tab").click(function(e) {
    e.preventDefault();
    $(".message").removeClass("active");
    $($(this).data("target")).addClass("active");
  })
  $("#all").click(function() {
    $(".message").addClass("active");

  });
});

$(document).ready(function() {
  $("#lost-click").click(function() {
    $(".dashboard-tab").removeClass("testwork");
    $(this).addClass("testwork-lost");
    $(".dashboard-tab").click(function() {
    $(".dashboard-tab").removeClass("testwork-lost")
    $("#lost-click").click(function() {
    $("#lost-click").addClass("testwork-lost")
    });
    });
  });
});

$(document).ready(function() {
  $(".dashboard-tab").click(function() {
    $(".dashboard-tab").removeClass("testwork");
    $(this).addClass("testwork");
  });
});


