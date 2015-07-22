$(document).ready(function(){

  $(document).on('click', 'i.glyphicon.glyphicon-envelope.friend_requests_active', function(){
    $.get('http://localhost:3000/messages/seen');
  });

  $(document).on('focusin', '.chat_window', function(){
    var senderID = $(this).find('input[class="chat_input"]').attr('receiver')
    console.log(senderID)
    $.get('http://localhost:3000/messages/seen_from?sender_id=' + senderID);
  });

});
