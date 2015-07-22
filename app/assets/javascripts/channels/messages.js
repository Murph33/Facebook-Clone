


App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data) {
    $('#chat_box' + data.channel).append(this.renderMessage(data))
    $('#chat_box' + data.channel).scrollTop($('#chat_box' + data.channel)[0].scrollHeight);
  },
  renderMessage: function(data) {
    var currentUserID = parseInt($("meta[name='user_id']").attr('value'))
    return currentUserID === data.sender_id ? ("<div class='user_send_container'> <div class='user_send'>" + data.message + "</div></div>") : ("<div class='user_receive_container'> <img style='left: 0px' src=" + data.sender_image + " /> <div class='user_receive'>" + data.message + "</div></div>")
  }
});
