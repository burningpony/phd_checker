class Round < ActiveRecord::Base
  belongs_to :user

  def calculated_time
    ((end_time - created_at) * 24 * 60 * 60).to_i
  end
end
