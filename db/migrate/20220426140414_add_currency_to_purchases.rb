class AddCurrencyToPurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :currency, :integer
  end
end
