class MessagesChannel < ApplicationCable::Channel
  def subscribed
    User.all.each do |u|
      User.all.each do |i|
        if u.id < i.id && u.id != i.id
          stream_from "#{u.id}_#{i.id}"
        end
      end
    end
  end
end
