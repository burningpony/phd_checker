require 'spec_helper'

RSpec.feature 'BGames', type: :feature, js: true do
  subject { page }

  scenario 'plays ?' do
    visit b_index_path
    fill_in :participant_id, with: 100
    fill_in :group_id, with: 400
    click_button 'start'
    sleep 0.3
    click_link 'Start'

    correct_essay(1, 1)
    correct_essay(1, 2)

    complete_round do
      expect(subject).to have_content('Total earnings so far:')

      within '.earnings' do
        expect(subject).to have_content('$2.70')
      end

      within '.round_earnings' do
        expect(subject).to have_content('$2.70')
      end
    end

    correct_essay(2, 3)
    correct_essay(2, 4)

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
