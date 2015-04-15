class User < ActiveRecord::Base
  require 'csv'
  has_many :responses, dependent: :destroy
  has_many :rounds, dependent: :destroy
  def self.aggregate_analysis(users)

    CSV.generate do |csv|
      csv << User.new.analyze.keys
      users.sort_by{|u| u.group}.each do |user|
        csv << user.analyze.values unless user.empty?
      end
    end
  end

  def analyze
    {
      id: id,
      group: group,
      data_id: participant_id,
      treatment: rounds.pluck(:name).compact.first.try(:to_i),
      total_time_taken: rounds.reduce(0) {|sum, r| r.calculated_time.to_i},
      total_edited: responses.count,
      total_correct: responses.where(correct: true).count,
      total_earned: total_payment,
      cumulative_impact: User.counter_part_impact(responses.where(correct: true).count,responses.where(correct: false).count),
      finished_early: rounds.where(completed_in_time: true).present?.to_i,
      created_at: created_at,
      round_1_edit: responses.where(round_number: 1).count,
      round_1_correct: responses.where(round_number: 1, correct: true).count,
      round_2_edit: responses.where(round_number: 2).count,
      round_2_correct: responses.where(round_number: 2, correct: true).count,
      round_3_edit: responses.where(round_number: 3).count,
      round_3_correct: responses.where(round_number: 3, correct: true).count,
      round_4_edit: responses.where(round_number: 4).count,
      round_4_correct: responses.where(round_number: 4, correct: true).count,
      calc_time_to_complete_round_1: rounds.where(round_number: 1).first.try(:calculated_time),
      calc_time_to_complete_round_2: rounds.where(round_number: 2).first.try(:calculated_time),
      calc_time_to_complete_round_3: rounds.where(round_number: 3).first.try(:calculated_time),
      calc_time_to_complete_round_4: rounds.where(round_number: 4).first.try(:calculated_time),
      round_1_earned: rounds.where(round_number: 1).pluck(:round_payment).first,
      round_2_earned: rounds.where(round_number: 2).pluck(:round_payment).first,
      round_3_earned: rounds.where(round_number: 3).pluck(:round_payment).first,
      round_4_earned: rounds.where(round_number: 4).pluck(:round_payment).first,
      counter_part_impact_1: round_impact(1),
      counter_part_impact_2: round_impact(2),
      counter_part_impact_3: round_impact(3),
      counter_part_impact_4: round_impact(4),
      finish_round_1_early: rounds.where(round_number: 1).pluck(:completed_in_time).first.to_i,
      finish_round_2_early: rounds.where(round_number: 2).pluck(:completed_in_time).first.to_i,
      finish_round_3_early: rounds.where(round_number: 3).pluck(:completed_in_time).first.to_i,
      finish_round_4_early: rounds.where(round_number: 4).pluck(:completed_in_time).first.to_i,
    }
  end

  def round_impact(round)
    User.counter_part_impact( responses.where(round_number: round, correct: true).count, responses.where(round_number: round, correct: false).count)
  end

  def self.counter_part_impact(number_correct, number_wrong)
    (0.15 * number_correct.to_f - 0.05 * number_wrong.to_f).round(5)
  end
end
