class AddTimeColumnsToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :total_time_to_edit, :float
  end
end
