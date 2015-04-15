class Round < ActiveRecord::Base
  belongs_to :user

  ##
  # Number of seconds spent on round
  # nil if cannot be established
  def calculated_time
    return if end_time.nil? || created_at.nil?
    (end_time - created_at).to_i
  end
end
