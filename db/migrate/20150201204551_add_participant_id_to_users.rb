class AddParticipantIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :participant_id, :string
  end
end
