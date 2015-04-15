require 'spec_helper'

RSpec.feature "FGames", :type => :feature, js: true do
  subject { page }

  scenario 'plays salary' do
    visit f_index_path
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
        expect(subject).to have_content('$25.00')
      end

      within '.round_earnings' do
        expect(subject).to have_content('-')
      end
    end

    correct_essay(2, 3)
    correct_essay(2, 4)

    complete_round

    correct_essay(3, 5)
    correct_essay(3, 6)

    complete_round

    correct_essay(4, 5)
    correct_essay(4, 6)

    finish_stage

    expect(subject).to have_content('Total earnings so far:')

    click_link 'Prepare this computer for the next trial'

    snapshot_user_page
  end
end
