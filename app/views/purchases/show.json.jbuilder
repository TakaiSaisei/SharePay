json.purchase do
  json.partial! 'purchase', purchase: @purchase, with_user_purchases: true
end
