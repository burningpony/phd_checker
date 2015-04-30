class AddCalculatedTimeToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :time_elapsed_in_seconds, :float
  end
end
