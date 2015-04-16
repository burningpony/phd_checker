FactoryGirl.define do

  factory :response do

    factory :incorrect_response do
      error '1_6'
      essay '#essay_1_1'
      correct false
      corrected 'blabla'
      uncorrected "you're"
      quota false
      correct_answer "you're"
      round_number 1
      controller '/c'
    end

    factory :correct_response do
      error '1_6'
      essay '#essay_1_1'
      correct true
      corrected "you're"
      uncorrected "you're"
      quota false
      correct_answer "you're"
      round_number 1
      controller '/c'
    end
  end

end
