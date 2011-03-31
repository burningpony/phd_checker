class AddGroupQuotaToResponses < ActiveRecord::Migration
  def self.up
    add_column :responses, :quota, :boolean
    add_column :responses, :group, :string
  end

  def self.down
    remove_column :responses, :qutoa
  end
end

