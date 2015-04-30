require 'spec_helper'

RSpec.feature 'CGames', type: :feature, js: true do
  subject { page }
  before do
    setup_test_counts
  end
  scenario 'plays 0.20 per error' do
    visit c_index_path
    fill_in :participant_id, with: random_number
    fill_in :group_id, with: random_number
    click_button 'start'
    sleep 0.3
    click_link 'Start'

    (1..10).each do |i|
      correct_essay(1, i)
    end

    complete_round do
      expect(subject).to have_content('Total earnings so far:')

      within '.earnings' do
        expect(subject).to have_content('$18.60')
      end

      within '.round_earnings' do
        expect(subject).to have_content('$18.60')
      end
    end

    (1..10).each do |i|
      correct_essay(2, i)
    end

    complete_round

    (1..10).each do |i|
      correct_essay(3, i)
    end

    complete_round

    (1..10).each do |i|
      correct_essay(4, i)
    end

    finish_stage

    expect(subject).to have_content('Total earnings so far:')

    within '.earnings' do
      expect(subject).to have_content('$75.00')
    end

    within '.round_earnings' do
      expect(subject).to have_content('$18.60')
    end

    click_link 'Prepare this computer for the next trial'

    within_window open_new_window do
      page.driver.resize(2000, 900)
      visit user_path(id: User.last.id)
      verify_responses
      expect(find('td.total_earned').text.to_f).to eq(75.0)
    end

    expect(User.last.analyze[:finish_round_1_early]).to have_content(1)
  end
end
