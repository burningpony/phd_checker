require 'spec_helper'

RSpec.feature 'AbuseGames', type: :feature, js: true do
  subject { page }
  before do
    setup_test_counts
  end
  scenario 'completes the test with entering no answers' do
    visit root_path
    within '#option-1' do
      click_button 'Select'
    end
    within '#experiment-a' do
      click_button 'Begin'
    end
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

  scenario 'completes the test with entering no answers' do
    visit root_path
    within '#option-2' do
      click_button 'Select'
    end
    within '#experiment-a' do
      click_link 'Begin'
    end
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

  scenario 'completes the test with entering no answers' do
    visit root_path
    within '#option-3' do
      click_button 'Select'
    end
    within '#experiment-a' do
      click_link 'Begin'
    end
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

  scenario 'abuse the essay links' do
    visit root_path
    within '#option-2' do
      click_button 'Select'
    end
    within '#experiment-f' do
      click_link 'Begin'
    end
    fill_in :participant_id, with: 100
    fill_in :group_id, with: 400
    click_button 'start'
    sleep 0.3
    click_link 'Start'

    (1..10).each do |i|
      click_link "Essay #{i}"
      click_link "Essay #{i}"
      click_link "Essay #{i}"
    end

    (1..10).each do |i|
      click_link "Essay #{i}"
      expect(page).to_not have_content('<input type="text" ')
    end
  end
end
