class AddAvailableOptionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :available_options, :string
  end
end
