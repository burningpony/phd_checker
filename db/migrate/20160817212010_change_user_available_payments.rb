class ChangeUserAvailablePayments < ActiveRecord::Migration
  def up
    remove_column :users, :available_payments, :string
    add_column :users, :available_payments, :json
  end

  def down
    add_column :users, :available_payments, :string
    remove_column :users, :available_payments, :json
  end
end
