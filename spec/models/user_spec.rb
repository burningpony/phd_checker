require 'spec_helper'

describe User do
  subject(:subject) { described_class.new() }

  describe "aggregate analysis" do
    it "will produce csv" do
      u = FactoryGirl.create(:user_with_responses, response_count: 5)
      expect(User.aggregate_analysis(User.all)).to end_with "\n"
    end

    it "will produce csv with no users" do
      expect(User.aggregate_analysis(User.all)).to eq nil
    end
  end
end
