require 'rails_helper'

RSpec.describe Round, :type => :model do
  subject(:round) { described_class.new() }
  describe "calculated_time" do
    it "will return nil if variables are not present" do
      round.created_at = Time.now
      round.end_time = nil
      expect(round.calculated_time).to  eq nil
    end

    it "will return nil if variables are not present" do
      round.created_at = nil
      round.end_time = nil
      expect(round.calculated_time).to  eq nil
    end

    it "will 420 when 7 minutes ahead" do
      round.created_at = Time.now
      round.end_time = 7.minutes.from_now
      expect(round.calculated_time).to  be_within(0.5).of(420)
    end
  end
end
