require 'spec_helper'

RSpec.feature 'FGames', type: :feature, js: true do
  subject { page }
  before do
    setup_test_counts
  end

  it 'plays salary' do
    visit phase_two_f_index_path
    fill_in :participant_id, with: random_number
    fill_in :group_id, with: random_number
    click_button 'start'
    sleep 0.9
    click_link 'Start'

    (1..10).each do |i|
      correct_essay(round: 1, number: i, option: 1)
    end

    complete_round do
      expect(subject).to have_content('Total earnings so far:')

      within '.earnings' do
        expect(subject).to have_content('$25.00')
      end

      within '.round_earnings' do
        expect(subject).to have_content('-')
      end
    end

    expect(page).to have_content('Round 2')

    (1..10).each do |i|
      correct_essay(round: 2, number: i, option: 1)
    end

    complete_round
    expect(page).to have_content('Round 3')
    (1..10).each do |i|
      correct_essay(round: 3, number: i, option: 1)
    end

    complete_round
    expect(page).to have_content('Round 4')

    (1..10).each do |i|
      correct_essay(round: 4, number: i, option: 1)
    end

    sleep 0.9
    finish_stage

    expect(subject).to have_content('Total earnings so far:')
    expect(User.last.analyze[:finish_round_4_early]).to have_content(1)
    click_link 'Prepare this computer for the next trial'

    snapshot_user_page
    verify_responses

    expect(@error_count).to eql(125)
    expect(@q_count).to eql(375)
    expect(@r_count).to eql(54)
    expect(Response.count).to eql(375)
    expect(
      Response.where(
        'correct_answer LIKE ? OR correct_answer like ?', '%r%', '%R%'
      ).count
    ).to eql(164)
  end

  it 'plays salary very poorly ' do
    visit phase_two_f_index_path
    fill_in :participant_id, with: 100
    fill_in :group_id, with: 400
    click_button 'start'
    sleep 0.9
    click_link 'Start'
    @start_time = Time.now
    (1..10).each do |i|
      correct_essay(round: 1, number: i, option: 1, get_it_right: false)
    end

    complete_round do
      expect(subject).to have_content('Total earnings so far:')

      within '.earnings' do
        expect(subject).to have_content('$25.00')
      end

      within '.round_earnings' do
        expect(subject).to have_content('-')
      end
    end

    (1..10).each do |i|
      correct_essay(round: 2, number: i, option: 1, get_it_right: false)
    end

    complete_round

    (1..10).each do |i|
      correct_essay(round: 3, number: i, option: 1, get_it_right: false)
    end

    complete_round

    (1..10).each do |i|
      correct_essay(round: 4, number: i, option: 1, get_it_right: false)
    end

    sleep 0.9
    finish_stage
    @end_time = Time.now
    expect(subject).to have_content('Total earnings so far:')
    expect(User.last.analyze[:finish_round_4_early]).to have_content(1)
    click_link 'Prepare this computer for the next trial'

    within_window open_new_window do
      page.driver.resize(2000, 900)
      visit user_path(id: User.last.id)
      time_elapsed = (@end_time - @start_time).ceil
      expect(
        find('td.total_time_taken'
            ).text.to_f).to be_within(5).of(time_elapsed)
      expect(
        find('td.calc_time_to_complete_round_1'
            ).text.to_f).to be < time_elapsed
      expect(
        find('td.calc_time_to_complete_round_2'
            ).text.to_f).to be < time_elapsed
      expect(
        find('td.calc_time_to_complete_round_3'
            ).text.to_f).to be < time_elapsed
      expect(
        find('td.calc_time_to_complete_round_4'
            ).text.to_f).to be < time_elapsed
    end

    # it gets them all wrong anyway derp derp

    expect(@error_count).to eql(125)
    expect(@q_count).to eql(375)
    expect(@r_count).to eql(54)
    expect(Response.count).to eql(375)
    expect(
      Response.where(
        'correct_answer LIKE ? OR correct_answer like ?', '%r%', '%R%'
      ).count
    ).to eql(164)
  end
end
