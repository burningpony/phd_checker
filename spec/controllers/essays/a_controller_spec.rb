require 'spec_helper'

describe AController do
  describe 'scorecard with errors' do
    let(:total_payment) {23}
    let(:round_payment) {24}
    let(:form) { {user_id: @u.id,
                   round_number: 4,
                   round_id: @round.id,
                   round_time: 157,
                   completed_in_time: 5,
                   option: option} }
    before do
      @u = FactoryGirl.create(:user_with_responses, response_count: 5)
      @round = Round.create(user_id: @u.id,
                           round_number: 1
                                  )

      payment_stubbed = double("payment", round_payment: round_payment, total_payment: total_payment)
      expect_any_instance_of(Payment).to receive(:a).with({:round_completed_essay=>0, :total_completed_essay=>1}).and_return(payment_stubbed)
      post :score_card, form.merge(format: 'json')
      expect(Payment).to respond_to(:new).with(option)
    end

    describe "option 1" do
      let(:option) {1}
      it 'returns payment' do
        expect(assigns(:total_payment)).to be total_payment
        expect(assigns(:round_payment)).to be round_payment
        @u.reload
        expect(@u.total_payment).to eq total_payment
      end
    end

    describe "option 2" do
      let(:option) {2}
      it 'returns payment' do
        expect(assigns(:total_payment)).to be total_payment
        expect(assigns(:round_payment)).to be round_payment
        @u.reload
        expect(@u.total_payment).to eq total_payment
      end
    end

    describe "option 3" do
      let(:option) {3}
      it 'returns payment' do
        expect(assigns(:total_payment)).to be total_payment
        expect(assigns(:round_payment)).to be round_payment
        @u.reload
        expect(@u.total_payment).to eq total_payment
      end
    end
  end
end
