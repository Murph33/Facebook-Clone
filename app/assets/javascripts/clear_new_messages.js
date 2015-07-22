$(document).ready(function(){

  $(document).on('click', 'i.glyphicon.glyphicon-envelope.friend_requests_active', function(){
    $.get('http://localhost:3000/messages/seen');
  });

  $(document).on('focusin', '.chat_window', function(){
    $.get('http://localhost:3000/messages/seen');
  });

});
