require 'spec_helper'

RSpec.feature 'BGames', type: :feature, js: true do
  subject { page }
  before do
    setup_test_counts
  end
  scenario 'plays ?' do
    visit b_index_path
    fill_in :participant_id, with: 100
    fill_in :group_id, with: 400
    click_button 'start'
    sleep 0.9
    click_link 'Start'

    correct_essay(round: 1, number: 1, option: 1)
    correct_essay(round: 1, number: 2, option: 1)

    complete_round do
      expect(subject).to have_content('Total earnings so far:')

      within '.earnings' do
        expect(subject).to have_content('$2.70')
      end

      within '.round_earnings' do
        expect(subject).to have_content('$2.70')
      end
    end

    correct_essay(round: 2, number: 3, option: 1)
    correct_essay(round: 2, number: 4, option: 1)

    complete_round do
      expect(subject).to have_content('Total earnings so far:')

      within '.earnings' do
        expect(subject).to have_content('$5.40')
      end

      within '.round_earnings' do
        expect(subject).to have_content('$2.70')
      end
    end
  end
end
