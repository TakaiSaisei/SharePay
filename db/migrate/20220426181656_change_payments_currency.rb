class ChangePaymentsCurrency < ActiveRecord::Migration[7.0]
  def up
    remove_column :payments, :currency
    add_column :payments, :currency, :integer
  end

  def down
    remove_column :payments, :currency
    add_column :payments, :currency, :string
  end
end
