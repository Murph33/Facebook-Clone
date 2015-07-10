$(document).ready(function(){

  autosize($('textarea'));

  $("body").on("keydown", "#comment_body", function(e){
    if (e.which === 13) {
      e.preventDefault()
      $(this).submit()
    }
  })

});
