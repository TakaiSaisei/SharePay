class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true, index: false
      t.string :description
      t.string :emoji
      t.timestamps
    end
  end
end
