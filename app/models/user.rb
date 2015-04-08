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
        'treatment',
        'total_time_taken',
        'total_edited',
        'total_correct',
        'total_earned',
        'cumulative_impact',
        'finished_early',
        'created_at',
        'round_1_edit',
        'round_1_correct',
        'round_2_edit',
        'round_2_correct',
        'round_3_edit',
        'round_3_correct',
        'round_4_edit',
        'round_4_correct',
        'time_to_complete_round_1',
        'time_to_complete_round_2',
        'time_to_complete_round_3',
        'time_to_complete_round_4',
        'round_1_earned',
        'round_2_earned',
        'round_3_earned',
        'round_4_earned',
        'counter_part_impact_1',
        'counter_part_impact_2',
        'counter_part_impact_3',
        'counter_part_impact_4',
        'finish_round_1_early',
        'finish_round_2_early',
        'finish_round_3_early',
        'finish_round_4_early'
      ]
      users.each do |user|
        csv << [
          user.id,
          user.group,
          user.participant_id,
          user.rounds.pluck(:name).first.try(:to_i),
          user.rounds.sum(:time_to_complete_in_seconds),
          user.responses.count,
          user.responses.where(correct: true).count,
          user.total_payment,
          User.counter_part_impact(user.responses.where(correct: true).count, user.responses.where(correct: false).count),
          user.rounds.where(completed_in_time: true).present?.to_i,
          user.created_at,
          user.responses.where(round_number: 1).count,
          user.responses.where(round_number: 1, correct: true).count,
          user.responses.where(round_number: 2).count,
          user.responses.where(round_number: 2, correct: true).count,
          user.responses.where(round_number: 3).count,
          user.responses.where(round_number: 3, correct: true).count,
          user.responses.where(round_number: 4).count,
          user.responses.where(round_number: 4, correct: true).count,
          user.rounds.where(round_number: 1).pluck(:time_to_complete_in_seconds).first.to_i,
          user.rounds.where(round_number: 2).pluck(:time_to_complete_in_seconds).first.to_i,
          user.rounds.where(round_number: 3).pluck(:time_to_complete_in_seconds).first.to_i,
          user.rounds.where(round_number: 4).pluck(:time_to_complete_in_seconds).first.to_i,
          user.rounds.where(round_number: 1).pluck(:round_payment).first.to_f,
          user.rounds.where(round_number: 2).pluck(:round_payment).first.to_f,
          user.rounds.where(round_number: 3).pluck(:round_payment).first.to_f,
          user.rounds.where(round_number: 4).pluck(:round_payment).first.to_f,
          user.round_impact(1),
          user.round_impact(2),
          user.round_impact(3),
          user.round_impact(4),
          user.rounds.where(round_number: 1).pluck(:completed_in_time).first.to_i,
          user.rounds.where(round_number: 2).pluck(:completed_in_time).first.to_i,
          user.rounds.where(round_number: 3).pluck(:completed_in_time).first.to_i,
          user.rounds.where(round_number: 4).pluck(:completed_in_time).first.to_i
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
