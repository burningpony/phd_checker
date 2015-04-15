def correct_essay(number)
  click_link "Essay #{number}"
  within "#essay_1_#{number}" do
    page.all(:css, '.correctme').each do |el|
      el.set el[:rel]
    end
  end
end
