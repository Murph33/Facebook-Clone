$(document).ready(function(){

  autosize($('textarea'));
  setInterval(function(){
    autosize($('textarea'))}, 1000)
  $("body").on("keydown", ".comment_body", function(e){
    console.log(this)
    if (e.which === 13) {
      e.preventDefault()
      $(this).parents("form").submit()
      // $(this).focus()
      // console.log($(this).parent().parent().parent())
      // setTimeout(function(){
      //   $(this).parent().parent().parent().find('textarea').focus()
      // }, 100)
    }
  })

  var search = $('[name="search_bar"]');
  var lastGoodVal;
  search.on('keyup', _.debounce(function () {
    var value = $(this).val();
    if (value !== lastGoodVal) {
      lastGoodVal = value;
      $.get("/users/search", {search: value});
    }
  }, 250));

  // $('div.row.background_grey').focus(function(){
  //   $('#replaceable').hide()
  // })
  // $(document).on("mousedown", "a", function(){
  //   window.location = $(this).attr("href");
  // });
  search.focus(function(){
    $('#replaceable').show();
  })

  var stop;
  search.blur(function(e){
    stop = setTimeout(function(){
      $('#replaceable').hide();
    },0);
  });

  $('div.form-group.slim').on('mousedown', 'div.search_result', function(){
    setTimeout(function(){
      clearTimeout(stop)
    },0)
  });

  




});
