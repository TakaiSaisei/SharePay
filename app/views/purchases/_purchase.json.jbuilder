with_user_purchases = false unless defined?(:with_user_purchases)

json.id purchase.id
json.name purchase.name
json.description purchase.description
json.emoji purchase.emoji
json.purchased_at purchase.purchased_at
json.currency purchase.currency

if with_user_purchases
  json.user_purchases purchase.user_purchases do |user_purchase|
    json.amount user_purchase.amount
    json.user_phone user_purchase.user.phone
  end
end
