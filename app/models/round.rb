class Round < ActiveRecord::Base
  belongs_to :user

  def calculated_time
    if end_time == nil || created_at == nil
      return nil
    end
    ((end_time - created_at) * 24 * 60 * 60).to_i
  end
end
