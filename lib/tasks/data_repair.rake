namespace :data do
  task :repair do
    responses = Response.where(correct: false, 'users.group' => '008').all(include: :user)
    puts responses.count.to_s + " incorrect"
    corrected_answers = 0
    responses.each do |r|
      unless r.correct_answer.length != r.corrected.length
        if sub_compare(r.corrected, r.correct_answer, 's', 'r')
          corrected_answers+= 1
          puts("response was: " + r.corrected.to_s)
          r.update_attributes(corrected: r.correct_answer, correct: true)
          puts("corrected_to: " + r.correct_answer.to_s + "\n")

        end
      end
    end
    puts corrected_answers.to_s + " corrected"
  end

  def sub_compare(corrected, answer, sub_letter, correct_letter)
    correct = false
    corrected.length.times do |i|
      good_sub = corrected[i] == sub_letter && answer[i] == correct_letter
      if corrected[i] == answer[i] || good_sub
        correct = true
      else
        correct = false
        break
      end
    end
    correct
  end
end
