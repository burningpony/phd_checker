require 'spec_helper'

describe FController do
  describe "scorecard with errors" do

    it "salary with errors" do
      u = FactoryGirl.create(:user_with_responses, response_count: 5)
      form = {user_id: u.id,
              round_number: 4,
              round_time: 157,
              completed_in_time: 5}

      post :score_card, form.merge(format: 'json')

      assigns(:total_payment).should be 25
      assigns(:round_payment).should be 0
      u.reload
      expect(u.total_payment).to eq 25.0
    end
  end
end
