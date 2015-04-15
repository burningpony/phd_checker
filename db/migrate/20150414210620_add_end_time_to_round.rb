class AddEndTimeToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :end_time, :datetime
  end
end
