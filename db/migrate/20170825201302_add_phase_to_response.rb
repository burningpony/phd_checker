class AddPhaseToResponse < ActiveRecord::Migration
  def up
    add_column :responses, :phase, :integer
  end

  def down
    remove_column :responses, :phase
  end
end
