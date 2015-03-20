class AddCompletedInTimeToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :completed_in_time, :boolean, default: false
  end
end
