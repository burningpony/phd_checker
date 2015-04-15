require 'spec_helper'

RSpec.feature "FullGames", :type => :feature, js: true do
  subject { page }

  scenario 'plays salary' do
    visit f_index_path
    fill_in :participant_id, with: 100
    fill_in :group_id, with: 400
    click_button 'start'
    sleep 0.3
    click_link 'Start'
    sleep 0.3

    within '#essay_1_1' do
      page.all(:css, '.correctme').each do |el|
        el.set el[:rel]
      end
    end
    click_link 'Essay 2'
    within '#essay_1_2' do
      page.all(:css, '.correctme').each do |el|
        el.set el[:rel]
      end
    end
    click_link 'Finish'
    click_button 'Confirm'

    expect(subject).to have_content('Total earnings so far:')

    within '.earnings' do
      expect(subject).to have_content('$25.00')
    end

    within '.round_earnings' do
      expect(subject).to have_content('-')
    end

    visit user_path(id: User.last.id)

    screenshot_and_open_image
  end
end
