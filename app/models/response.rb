class Response < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  scope :incorrect, where(correct: false)
  scope :correct, where(correct: true)
end
