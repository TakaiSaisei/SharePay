# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  phone      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  def owes(user)
    Payment.where(sender: self, receiver: user).sum(:amount) -
      UserPurchase.includes(:purchase).where('user_purchases.user': self, 'purchases.user': user).sum(:amount)
  end
end
