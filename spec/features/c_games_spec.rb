require 'spec_helper'

RSpec.feature 'CGames', type: :feature, js: true do
  subject { page }
  before do
    setup_test_counts
  end
  scenario 'plays 0.20 per error' do
    visit c_index_path
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
        expect(subject).to have_content('$4.80')
      end

      within '.round_earnings' do
        expect(subject).to have_content('$4.80')
      end
    end

    correct_essay(2, 3)
    correct_essay(2, 4)

    complete_round do
      expect(subject).to have_content('Total earnings so far:')

      within '.earnings' do
        expect(subject).to have_content('$9.00')
      end

      within '.round_earnings' do
        expect(subject).to have_content('$4.20')
      end
    end

    expect(User.last.analyze[:finish_round_1_early]).to have_content(1)
  end
end
