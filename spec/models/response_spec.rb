require 'spec_helper'

describe Response do
  describe 'raw csv' do
    it 'will produce csv' do
      u = FactoryGirl.create(:user_with_responses, response_count: 5)
      expect(Response.raw_csv(Response.all)).to end_with "\n"
    end
  end

  describe "set correct" do
    it "sets correct to true when uncorrected = corrected on save" do
      user = FactoryGirl.create(:user)
      subject = FactoryGirl.create(:response, user: user, round_number: 1, correct_answer: "hift", corrected: "hift")
      expect(subject.correct).to eq true
    end

    it "sets correct to true when uncorrected != corrected on save" do
      user = FactoryGirl.create(:user)
      subject = FactoryGirl.create(:response, user: user, round_number: 1, correct_answer: "hi", corrected: "hif")
      expect(subject.correct).to eq false
    end
  end

  describe "update actions and set total_time" do
    before do
      @time_now = Time.new(2015,10,10)
      @user = FactoryGirl.create(:user)
      @round = FactoryGirl.create(:round, round_number: 1, user: @user)
      allow(Time).to receive(:current).and_return(@time_now)
      allow(@round).to receive(:updated_at).and_return(@time_now)

      @response_1 = FactoryGirl.create(:response, user: @user, round_number: @round.round_number, correct_answer: "hi", corrected: "hi")

      @response_2 = FactoryGirl.create(:response, user: @user, round_number: @round.round_number, correct_answer: "no", corrected: "hi")
    end

    it "first create" do
      expect(@response_1.actions).to eq [{last_response: nil, time_since_last_action: (@time_now - @round.created_at).round(6), correct?: true, time_of_action:  @time_now}.to_json]
      expect(@response_1.total_time_to_edit).to eq (@time_now - @round.created_at).round(6)
    end

    it "second create" do
      expect(@response_2.actions).to eq [{last_response: @response_1.id, time_since_last_action: (@time_now - @response_1.created_at).round(6), correct?: false, time_of_action:  @time_now}.to_json]
    end

    it "on update" do
      @response_2.update(correct_answer: "no", corrected: "no")
      expect(@response_2.actions).to eq [{last_response: @response_1.id, time_since_last_action: (@time_now - @response_1.created_at).round(6), correct?: false, time_of_action:  @time_now}.to_json, {last_response: @response_2.id, time_since_last_action: (@time_now - @response_2.created_at).round(6), correct?: true, time_of_action:  @time_now}.to_json]
      expect(@response_2.total_time_to_edit.round(0)).to eq ((@time_now - @round.created_at) + (@time_now - @response_2.created_at)).round(0)
    end
  end

  def truncate_to(number, places)
    ((number * (10**places)).floor) / 10.0**places
  end
end
