class AddRoundNumberToUser < ActiveRecord::Migration
  def change
    add_column :responses, :round_number, :integer
  end
end
