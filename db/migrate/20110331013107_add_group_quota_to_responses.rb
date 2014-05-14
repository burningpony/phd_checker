class AddGroupQuotaToResponses < ActiveRecord::Migration
  def self.up
    add_column :responses, :quota, :boolean
    add_column :users, :group, :string
  end

  def self.down
    remove_column :responses, :quota
    remove_column :users, :quota
  end
end
