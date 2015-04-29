FactoryGirl.define do

  factory :user do
    # name 'King Sam'
    group 1
    time_to_complete 427
    participant_id 1

    factory :user_with_errors do

      transient do
        response_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:incorrect_response, evaluator.response_count, user: user)
      end
    end

    factory :user_with_responses do

      transient do
        response_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:correct_response, evaluator.response_count, user: user)
      end
      after(:create) do |user, evaluator|
        create_list(:incorrect_response, evaluator.response_count, user: user)
      end
    end
  end
end
