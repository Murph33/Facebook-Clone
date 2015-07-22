class MessagesController < ApplicationController

  before_action :verify_account!
  before_action :authenticate_user!

  def create
    message_params = params.require(:message).permit(:sender_id, :receiver_id,
                                                      :body)
    @message = current_user.sent_messages.new message_params
    if @message.save
      channel = [@message.sender_id, @message.receiver_id].sort.join("_")
      # some_var = "message"
      # ActionCable.server.broadcast "messages",
      #   message: params[:message][:body],
      #   sender: @message.sender.full_name
      ActionCable.server.broadcast channel,
        message: params[:message][:body],
        sender: @message.sender.full_name,
        sender_id: @message.sender_id,
        sender_image: @message.sender.picture.url(:comment),
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

  def seen_all
    current_user.unseen_messages.update_all seen: true
  end

  def seen_from
    current_user.unseen_messages.where(sender_id: params[:sender_id]).update_all seen: true
  end

  def conversation
  @user1 = current_user
  @user2 = params[:user2]
  @conversation = Message.find_conversation(current_user.id, params[:user2])
  if @conversation.empty?
    Message.create(sender_id: current_user.id, receiver_id: params[:user2], body:"")
  end
  @conversation ||= Message.find_conversation(current_user.id, params[:user2])
  end

end
