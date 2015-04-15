require 'spec_helper'

RSpec.feature "FGames", :type => :feature, js: true do
  subject { page }

  scenario 'completes the test with entering no answers' do
    visit a_index_path
    fill_in :participant_id, with: 100
    fill_in :group_id, with: 400
    click_button 'start'
    sleep 0.3
    click_link 'Start'

    complete_round
    sleep 0.3
    complete_round
    sleep 0.3
    complete_round do
      expect(subject).to have_content('Total earnings so far:')

      within '.earnings' do
        expect(subject).to have_content('$0.00')
      end

      within '.round_earnings' do
        expect(subject).to have_content('$0.00')
      end
    end

    finish_stage

    expect(subject).to have_content('Total earnings so far:')
    expect(User.last.analyze[:finish_round_4_early]).to have_content(1)
    expect(User.last.responses.count).to eq(0)
    click_link 'Prepare this computer for the next trial'

    snapshot_user_page
  end
end
