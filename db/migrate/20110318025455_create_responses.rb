class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|

      t.integer :user_id
      t.string :error
      t.string :essay
      t.boolean :correct
      t.string :corrected
      t.string :uncorrected

      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
