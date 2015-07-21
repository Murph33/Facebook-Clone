class MessagesController < ApplicationController

  before_action :verify_account!
  before_action :authenticate_user!

  def create
    message_params = params.require(:message).permit(:sender_id, :receiver_id,
                                                      :body)
    @message = Message.new message_params
    if @message.save
      channel = [@message.sender_id, @message.receiver_id].sort.join("_")
      # some_var = "message"
      # ActionCable.server.broadcast "messages",
      #   message: params[:message][:body],
      #   sender: @message.sender.full_name
      ActionCable.server.broadcast channel,
        message: params[:message][:body],
        sender: @message.sender.full_name,
        channel: channel
      # ActionCable.server.broadcast some_var,
      #   message: params[:message][:body],
      #   sender: @message.sender.full_name,
      #   channel: channel

      head :ok
    else
      render { create_failure }
    end
  end

  def index
  end

  def conversation
  @user1 = params[:user_1]
  @user2 = params[:user_2]
  @conversation = Message.find_conversation(params[:user_1], params[:user_2])

  end

end
