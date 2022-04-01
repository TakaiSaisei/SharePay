class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :sender, foreign_key: { to_table: :users }, index: false
      t.references :receiver, foreign_key: { to_table: :users }, index: false
      t.string :currency, null: false
      t.timestamps
    end
  end
end
