class User < ActiveRecord::Base
  require 'csv'
  has_many :responses, dependent: :destroy
  has_many :rounds, dependent: :destroy
  def self.aggregate_analysis(users)
    CSV.generate do |csv|
      csv << [
        'id',
        'group',
        'data_id',
        'round_1_edit',
        'round_1_correct',
        'round_2_edit',
        'round_2_correct',
        'round_3_edit',
        'round_3_correct',
        'round_4_edit',
        'round_4_correct',
        'total_edited',
        'total_correct',
        'total_earned',
        'treatment',
        'time_to_complete_round_1',
        'time_to_complete_round_2',
        'time_to_complete_round_3',
        'time_to_complete_round_4',
        'total_time_taken',
        'Finish_early',
        'round_1_earned',
        'round_2_earned',
        'round_3_earned',
        'round_4_earned',
        'counter_part_impact_1',
        'counter_part_impact_2',
        'counter_part_impact_3',
        'counter_part_impact_4',
        'created_at'
      ]
      users.each do |user|
        csv << [
          user.id,
          user.group,
          user.participant_id,
          user.responses.where(round_number: 1).count,
          user.responses.where(round_number: 1, correct: true).count,
          user.responses.where(round_number: 2).count,
          user.responses.where(round_number: 2, correct: true).count,
          user.responses.where(round_number: 3).count,
          user.responses.where(round_number: 3, correct: true).count,
          user.responses.where(round_number: 4).count,
          user.responses.where(round_number: 4, correct: true).count,
          user.responses.count,
          user.responses.where(correct: true).count,
          user.rounds.sum(:round_payment),
          user.rounds.first.name,
          user.rounds.where(round_number: 1).first.time_to_complete_in_seconds,
          user.rounds.where(round_number: 2).first.time_to_complete_in_seconds,
          user.rounds.where(round_number: 3).first.time_to_complete_in_seconds,
          user.rounds.where(round_number: 4).first.time_to_complete_in_seconds,
          user.rounds.sum(:time_to_complete_in_seconds),
          user.rounds.where(round_number: 4).first.completed_in_time,
          user.rounds.where(round_number: 1).first.round_payment,
          user.rounds.where(round_number: 2).first.round_payment,
          user.rounds.where(round_number: 3).first.round_payment,
          user.rounds.where(round_number: 4).first.round_payment,
          user.round_impact(1),
          user.round_impact(2),
          user.round_impact(3),
          user.round_impact(4),
          user.created_at
        ]
      end
    end
  end

  def round_impact(round)
    User.counter_part_impact( responses.where(round_number: round, correct: true).count, responses.where(round_number: round, correct: false).count)
  end

  def self.counter_part_impact(number_correct, number_wrong)
    0.15 * number_correct.to_f - 0.05 * number_wrong.to_f
  end

  
end
