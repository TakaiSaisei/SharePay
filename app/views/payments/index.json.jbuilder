json.array! @payments do |payment|
  json.amount current_user.id == payment.sender_id ? -payment.amount : payment.amount
  json.sender_phone payment.sender.phone
  json.receiver_phone payment.receiver.phone
  json.created_at payment.created_at
end
