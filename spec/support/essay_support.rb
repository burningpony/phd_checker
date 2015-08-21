def correct_essay(round: 1,  number: 1, option: 1, get_it_right: true)
  uncorrected_answers = {}
  click_link "Essay #{number}"
  wait_for_ajax
  within "#o1_e#{round}_#{number}" do
    # loop through and count things
    page.all(:css, '.correctme').each do |el|
      correct_value = el['rel']
      uncorrected_value = el.find('input').value.to_s.dup
      uncorrected_answers[el['id']] = uncorrected_value

      @error_count += 1 if correct_value != uncorrected_value
      @r_count += 1 if correct_value != uncorrected_value && correct_value =~ /[rR]/
    end

    # empty all fields
    page.execute_script "$('.correctme input').val('')"

    page.all(:css, '.correctme').each do |el|
      # expect(uncorrected_value).to eq('')
      correct_value = el['rel']
      uncorrected_value = uncorrected_answers[el['id']]
      expect(el.find('input').value).to eq('')

      if get_it_right
        el.find('input').native.send_keys(*correct_value)
        expect(el.find('input').value).to eq correct_value
      else
        el.find('input').native.send_keys(*uncorrected_value)
        expect(el.find('input').value).to eq uncorrected_value
        script = "$('#{el['id'].strip}').trigger('change');"
        page.execute_script(script)
      end

    end
    @q_count += page.all(:css, '.correctme').size
  end
end

def complete_round(&block)
  finish_stage
  wait_for_ajax
  block.call if block_given?
  click_button 'Done'
  wait_for_ajax
end

def finish_stage
  click_link 'Finish'
  wait_for_ajax
  click_button 'Confirm'
  wait_for_ajax
end

def verify_responses
  page.all(:css, '.response').each do |el|
    expect(el.find('td.corrected').text).to eq(el.find('td.correct_answer').text)
  end
end

def snapshot_user_page
  within_window open_new_window do
    page.driver.resize(2000, 900)
    visit user_path(id: User.last.id)
    verify_responses
    # screenshot_and_open_image
  end
end

def random_number
  '0000' + Random.rand(100..9999).to_s
end

def setup_test_counts
  @q_count = 0
  @r_count = 0
  @error_count = 0
end
