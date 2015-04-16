require 'spec_helper'

describe Response do
  describe 'raw csv' do
    it 'will produce csv' do
      u = FactoryGirl.create(:user_with_responses, response_count: 5)
      expect(Response.raw_csv(Response.all)).to end_with "\n"
    end
  end
end
