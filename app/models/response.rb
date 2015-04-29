class Response < ActiveRecord::Base
  require 'csv'
  belongs_to :user
  validates :user_id, presence: true
  validates :corrected, length: { maximum: 100 }
  scope :incorrect, -> { where(correct: false) }
  scope :correct, -> { where(correct: true) }

  before_validation :set_correct

  def set_correct
    assign_attributes(correct: correct_answer == corrected)
  end

  def self.raw_csv(responses)
    CSV.generate do |csv|
      # header row
      csv << [
        'id',
        'group',
        'participant_id',
        'error',
        'essay',
        'Correct?',
        'Field Before Correction',
        'Seconds to Complete',
        'Round',
        'Treatment',
        'Time Corrected'
      ]

      # data rows
      responses.each do |response|
        csv << [
          response.id,
          response.user_id,
          response.user.group,
          response.error,
          response.essay,
          response.correct,
          response.uncorrected,
          response.round_number,
          response.user.time_to_complete,
          response.controller,
          response.created_at
        ]
      end
    end
  end

  private
end
