class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.references :user
      t.integer :time_to_complete_in_seconds
      t.string :name
      t.string :treatment
      t.integer :round_number
      t.float :running_total_payment
      t.float :round_payment

      t.timestamps
    end
    add_index :rounds, :user_id
  end
end
