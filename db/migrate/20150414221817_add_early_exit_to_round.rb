class AddEarlyExitToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :early_exit, :boolean
  end
end
