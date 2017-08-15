class AddPhaseToResponses < ActiveRecord::Migration
  def up
    add_column :responses, :phase, :string
  end

  def down
    remove_column :responses, :phase
  end
end
