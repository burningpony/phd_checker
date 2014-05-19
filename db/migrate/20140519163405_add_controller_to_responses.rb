class AddControllerToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :controller, :string
  end
end
