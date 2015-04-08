class AddTotalPaymentToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_payment, :float, default: 0.0
  end
end
