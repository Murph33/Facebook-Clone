$(document).ready(function(){

  autosize($('textarea'));
  setInterval(function(){
    autosize($('textarea'))}, 1000)
  $("body").on("keydown", "#comment_body", function(e){
    if (e.which === 13) {
      e.preventDefault()
      $(this).submit()
    }
  })

});
