class AddOptionToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :option, :integer
  end
end
