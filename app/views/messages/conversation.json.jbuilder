json.array! @conversation do |conversation|
  json.sender_id        conversation.sender.id
  json.receiver_id      conversation.receiver.id
  json.sender_name      conversation.sender.full_name
  json.receiver_name    conversation.receiver.full_name
  json.body             conversation.body
  json.sender_image     conversation.sender.picture.url(:comment)
  json.receiver_image     conversation.receiver.picture.url(:comment)
end
