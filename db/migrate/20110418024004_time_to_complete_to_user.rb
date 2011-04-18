class TimeToCompleteToUser < ActiveRecord::Migration
  def self.up
        add_column :users, :time_to_complete, :string
  end

  def self.down
          remove_column :users, :time_to_complete
  end
end
