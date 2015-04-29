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
    fill_in :participant_id, with: "0000" + Random.rand(100..9999).to_s
    fill_in :group_id, with: "0000" + Random.rand(100..9999).to_s
    click_button 'start'
    sleep 0.3
    click_link 'Start'

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
  end
end
