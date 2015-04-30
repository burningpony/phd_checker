require 'rails_helper'

WEBSITE_URL = 'http://stark-sands-8796.herokuapp.com/'

RSpec.feature 'Smokes', type: :feature, js: true, smoke: true do
  subject { page }
  before do
    setup_test_counts
    Capybara.run_server = false
    Capybara.app_host = WEBSITE_URL
  end

  it 'plays salary' do
    visit f_index_path
    fill_in :participant_id, with: random_number
    fill_in :group_id, with: random_number
    click_button 'start'
    sleep 0.3
    click_link 'Start'
    @start_time = Time.now
    (1..4).each do |round|
      (1..10).each do |i|
        correct_essay(round, i)
      end

      if round < 4
        complete_round
      else
        sleep 0.3
        finish_stage
        click_link 'Prepare this computer for the next trial'
      end
    end

    @end_time = Time.now
    expect(subject).to have_content('Total earnings so far:')
    click_link 'Prepare this computer for the next trial'

    # within_window open_new_window do
    #   page.driver.resize(2000, 900)
    #   visit user_path(id: 4)
    #   # verify_responses
    #   screenshot_and_open_image
    #   time_elapsed = (@end_time - @start_time).ceil
    #   expect(find('td.total_time_taken').text.to_f).to be_within(5).of(time_elapsed)
    #   expect(find('td.calc_time_to_complete_round_1').text.to_f).to be < time_elapsed
    #   expect(find('td.calc_time_to_complete_round_2').text.to_f).to be < time_elapsed
    #   expect(find('td.calc_time_to_complete_round_3').text.to_f).to be < time_elapsed
    #   expect(find('td.calc_time_to_complete_round_4').text.to_f).to be < time_elapsed
    # end

    # it gets them all wrong anyway derp derp
    expect(@error_count).to eql(125)
    expect(@q_count).to eql(375)
    expect(@r_count).to eql(54)
  end

end
