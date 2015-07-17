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

  $(document).on('mousedown', ".see_more", function() {
    $(this).siblings('.truncated_text').html($(this).attr('text'))
    $(this).remove()
  });

  var tagging_field = "<input type='text' id='tagging_field' style='width: 92%; outline: none; margin: 4px 0 4px 0;' placeholder='Tag a friend!' style='display: inline-block;'>"

  $(document).on('mousedown', '.tag_photo', function(){
    $(this).parent().append(tagging_field)
    $(this).siblings('.tagged_users').removeClass('hidden')
    $(this).html('Finish Tagging').removeClass('tag_photo').addClass('finish_tagging')
  });

  $(document).on('mousedown', '.finish_tagging', function(){
    $(this).siblings('#tagging_field').remove()
    $(this).siblings('.tagged_users').addClass('hidden')
    $(this).siblings('.tag_placeholder').html('')
    $(this).html('Tag Photo').addClass('tag_photo').removeClass('finish_tagging')
  });

  var tag = $('[id="tagging_field"]');
  var lastGoodTagVal;
  $(document).on('keyup', '[id="tagging_field"]', _.debounce(function (e) {
    var tagValue = $(e.target).val();
    var photo_id = $(e.target).parents('.photo_id_div').attr('photo_id')
    if (tagValue !== lastGoodTagVal) {
      lastGoodTagVal = tagValue;
      $.get("/users/tagging_friends_search", {search: tagValue, photo_id: photo_id});
    }
  }, 250));

  $(document).on('mousedown', '.tagging_search_result', function() {
    var user = $(this).attr('user_id');
    var photo = $(this).parents('.photo_id_div').attr('photo_id');
    $.post('/taggings/', {tagging: {user_id: user, photo_id: photo}});
    $(this).remove()
  });


});
