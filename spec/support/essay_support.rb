def correct_essay(round, number, get_it_right: true)

  sleep 0.5
  click_link "Essay #{number}"
  within "#essay_#{round}_#{number}" do
    # loop through and count things
    page.all(:css, '.correctme').each do |el|
      correct_value = el['rel']
      uncorrected_value = el.find('input').value.dup
      @error_count += 1 if correct_value != uncorrected_value
      @r_count += 1 if correct_value != uncorrected_value && correct_value =~ /[rR]/

      # empty all fields
      page.execute_script "$('.correctme input').val('')"
      # expect(uncorrected_value).to eq('')
      expect( el.find('input').value ).to eq('')

      if get_it_right
        el.find('input').native.send_keys( *correct_value )
        expect(el.find('input').value).to eq correct_value
      else
        el.find('input').native.send_keys( *uncorrected_value )
        expect(el.find('input').value).to eq uncorrected_value
        script = "$('#{el['id'].strip}').trigger('change');"
        page.execute_script(script);
      end

    end
    @q_count += page.all(:css, '.correctme').size
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
    screenshot_and_open_image
  end
end

def setup_test_counts
  @q_count = 0
  @r_count = 0
  @error_count = 0
end
