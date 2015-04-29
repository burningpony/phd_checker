require 'spec_helper'

RSpec.feature 'FGames', type: :feature, js: true do
  subject { page }
  before do
    setup_test_counts
  end

  it 'plays salary' do
    visit f_index_path
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
        expect(subject).to have_content('$25.00')
      end

      within '.round_earnings' do
        expect(subject).to have_content('-')
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

    sleep 0.3
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
    expect(Response.where('correct_answer LIKE ? OR correct_answer like ?', '%r%', '%R%').count).to eql(164)
  end

  it 'plays salary very poorly ' do
    visit f_index_path
    fill_in :participant_id, with: 100
    fill_in :group_id, with: 400
    click_button 'start'
    sleep 0.3
    click_link 'Start'

    (1..10).each do |i|
      correct_essay(1, i, get_it_right: false)
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
      correct_essay(2, i, get_it_right: false)
    end

    complete_round

    (1..10).each do |i|
      correct_essay(3, i, get_it_right: false)
    end

    complete_round

    (1..10).each do |i|
      correct_essay(4, i, get_it_right: false)
    end

    sleep 0.3
    finish_stage

    expect(subject).to have_content('Total earnings so far:')
    expect(User.last.analyze[:finish_round_4_early]).to have_content(1)
    click_link 'Prepare this computer for the next trial'

    # snapshot_user_page

    # it gets them all wrong anyway derp derp

    expect(@error_count).to eql(125)
    expect(@q_count).to eql(375)
    expect(@r_count).to eql(54)
    expect(Response.count).to eql(375)
    expect(Response.where('correct_answer LIKE ? OR correct_answer like ?', '%r%', '%R%').count).to eql(164)
  end
end
