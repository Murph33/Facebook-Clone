class MessagesChannel < ApplicationCable::Channel
  # def subscribed
  #   User.all.each do |u|
  #     if u.id < current_user.id && u.id != current_user.id
  #       stream_from "#{u.id}_#{current_user.id}"
  #     elsif u.id > current_user.id && u.id != current_user.id
  #       stream_from "#{current_user.id}_#{u.id}"
  #     end
  #   end
  # end
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
