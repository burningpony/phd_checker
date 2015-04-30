class Round < ActiveRecord::Base
  belongs_to :user
  before_validation :calculate_time
  ##
  # Number of seconds spent on round
  # nil if cannot be established
  def calculate_time
    return if end_time.nil? || created_at.nil?
    assign_attributes(time_elapsed_in_seconds: (end_time - created_at).round(2))
  end
end
