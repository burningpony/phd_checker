class AddAvailableOptionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :available_payments, :string
  end
end
