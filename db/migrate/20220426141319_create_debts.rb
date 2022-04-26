class CreateDebts < ActiveRecord::Migration[7.0]
  def change
    create_table :debts do |t|
      t.references :debtor, foreign_key: { to_table: :users }
      t.references :creditor, foreign_key: { to_table: :users }
      t.float :amount, null: false
    end
  end
end
