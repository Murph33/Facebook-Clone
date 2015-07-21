
App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data) {
    console.log("does this work?")
     $('body').append(this.renderMessage(data));
    console.log($('#' + data.channel).append(this.renderMessage(data)))
  },
  renderMessage: function(data) {
    return "<p><b>[" + data.sender + "]:</b> " + data.message + data.channel + "</p>";
  }
});
