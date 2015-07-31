$(document).ready(function(){

  $(document).on('click', '#chat_bar', function(){
    $('#friends_chat_list').toggleClass("hidden")
  });
  $(document).on('click', 'div[friend-id]', function(){
    $.get( "http://fakestbook.herokuapp.com/messages/conversation.json", {user2: $(this).attr('friend-id')},
            function(data){
              var firstID = (data[0]["sender_id"] > data[0]["receiver_id"]) ?
                              data[0]["receiver_id"] : data[0]["sender_id"]
              var secondID = (data[0]["sender_id"] > data[0]["receiver_id"]) ?
                              data[0]["sender_id"] : data[0]["receiver_id"]
              var divID = firstID + "_" + secondID
              var newChatWindow = $("<div class='chat_window' id=" + divID + " />")
              var newChatBox = $("<div class='chat_box' id=chat_box" + divID + " />")
              var newChatHeader = $('<div class="chat_header" />')
              data[0]["sender_id"] == ($(this).attr('friend-id')) ?
              (newChatHeader.html("<span class='message_header_name' friend_id='" + data[0]["sender_id"] + "'>" + (data[0]["sender_name"]) + "</span>")) :
              (newChatHeader.html("<span class='message_header_name' friend_id='" + data[0]["receiver_id"] + "'>" + (data[0]["receiver_name"]) + "</span>"))
              if ($('div.chat_window#' + divID).length > 0) {

              } else {
                $('#active_chat_container').append(newChatWindow)
                $('#' + divID).append(newChatHeader)
                $('#' + divID).append(newChatBox)
                data.forEach(function(ele,index){
                  data[index]["sender_id"] == ($(this).attr('friend-id')) ?  $('#chat_box' + divID).append( "<div class='user_receive_container'> <img style='left: 0px' src=" + ele.sender_image + " /> <div class='user_receive'>" + ele["body"] + "</div></div>") : $('#chat_box' + divID).append( "<div class='user_send_container'> <div class='user_send'>" + ele["body"] + "</div></div>")
                }.bind(this));
                $('#' + divID).append("<input type='text' receiver='" + $(this).attr('friend-id') + "' class='chat_input' />")
                $('#chat_box' + divID).scrollTop($('#chat_box' + divID)[0].scrollHeight);
                setTimeout(function(){
                  $('#chat_box' + divID).scrollTop($('#chat_box' + divID)[0].scrollHeight);
                },10)
              }
            }.bind(this))
  });

  $(document).on('keyup', 'input.chat_input', function(e){
     if (e.which === 13) {
       e.preventDefault();
       $.post("http://fakestbook.herokuapp.com/messages",
              { message: { receiver_id: $(this).attr('receiver'),
                           body: $(this).val() }}, function(){
                              setTimeout(function(){
                                $(this).siblings('.chat_box')
                                    .scrollTop($(this)
                                    .siblings('.chat_box')[0].scrollHeight);
                              }.bind(this),0)
                            }.bind(this));
       $(this).val('');

     };
  });

  $(document).on('click', '.chat_header', function(){
    $(this).parents('.chat_window').remove();
  });

  $(document).on('click', 'span.message_header_name', function(e){
    e.stopPropagation()
    var id = $(this).attr('friend_id')
    window.location.href=("http://fakestbook.herokuapp.com/users/" + id)
    console.log("http://fakestbook.herokuapp.com/users/" + id)
  })

});
