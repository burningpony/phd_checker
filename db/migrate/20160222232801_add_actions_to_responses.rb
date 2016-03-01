class AddActionsToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :actions, :json
  end
end
