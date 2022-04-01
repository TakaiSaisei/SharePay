class CreateUserPurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :user_purchases do |t|
      t.references :purchase, foreign_key: true
      t.references :user, foreign_key: true
      t.float :amount, null: false
      t.timestamps
    end
  end
end
