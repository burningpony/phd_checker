def correct_essay(round, number)
  sleep 0.3
  click_link "Essay #{number}"
  within "#essay_#{round}_#{number}" do
    page.execute_script "$('.correctme input').val('')"
    page.all(:css, '.correctme').each do |el|
      # page.execute_script "$('##{el['id'].strip}').val(\"#{escape_javascript el['rel']}\").keydown()"
      # page.execute_script "$('##{el['id'].strip} input').val('')"
      expect(el.find('input').value).to eq ''
      el.find('input').native.send_keys( *el['rel'] )

      # page.execute_script "console.log($('##{el['id'].strip} input').val())"
      expect(el.find('input').value).to eq el['rel']
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

def verify_responses
  page.all(:css, '.response').each do |el|
    expect(el.find('td.corrected').text).to eq(el.find('td.correct_answer').text)
  end
end

def snapshot_user_page
  within_window open_new_window do

    visit user_path(id: User.last.id)
    verify_responses
    # screenshot_and_open_image
  end
end
