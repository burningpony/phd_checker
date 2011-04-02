class AddCorrectAnswer < ActiveRecord::Migration
  def self.up
    add_column :responses, :correct_answer, :string
  end

  def self.down
    remove_column :responses, :correct_answer
  end
end
