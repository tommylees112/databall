// function myJsFunction() {
//   var text = document.getElementById('inlineFormInputGroup')
//   text.addEventListener('keyup', function() {
//   var newText = document.getElementById('insert-text')
//   var newMatchRating = document.getElementById('new_match')
//   let test1 = parseInt(newMatchRating, 10) * parseInt(text.value, 10)
// console.log(text)
// console.log(test1)
//   })
// }

$(document).ready(function() {
  $(".form-input-odd").on("keyup", function() {

    var calc = ((parseInt($(this).val(), 10) * parseInt($("#new_match").text())) / 100)
    // console.log($("#new_match").text());
    var selector = $(this).data('insert');
    if (calc) {
      $(selector).text(calc);
    }
  })
  })

