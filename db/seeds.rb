if Rails.env.development?
  User.create(name: 'Nikita Kolesnikov', phone: '79092221133')
  purchase = Purchase.create(name: 'Purchase', user: User.take, description: 'Description')
  purchase.user_purchases.create(amount: 100, user: User.take)
end
