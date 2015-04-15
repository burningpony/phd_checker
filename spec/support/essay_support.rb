def correct_essay(round, number)
  sleep 0.2
  click_link "Essay #{number}"
  within "#essay_#{round}_#{number}" do
    page.all(:css, '.correctme').each do |el|
      el.set el[:rel]
    end
  end
end

def complete_round(&block)
  finish_stage
  block.call if block_given?
  click_button 'Done'
end

def finish_stage
  click_link 'Finish'
  click_button 'Confirm'
end

def snapshot_user_page
  # page.execute_script('window.onbeforeunload = undefined;')
  # page.execute_script('window.onunload = undefined;')

  # visit user_path(id: User.last.id)
  # screenshot_and_open_image
end
