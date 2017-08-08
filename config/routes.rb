PhdChecker::Application.routes.draw do
  get ':phase/a/score_card'                               => 'a#score_card'
  get ':phase/b/score_card'                               => 'b#score_card'
  get ':phase/c/score_card'                               => 'c#score_card'
  get ':phase/d/score_card'                               => 'd#score_card'
  get ':phase/e/score_card'                               => 'e#score_card'
  get ':phase/f/score_card'                               => 'f#score_card'
  get ':phase/g/score_card'                               => 'g#score_card'
  get ':phase/h/score_card'                               => 'h#score_card'

  namespace :phase_two do
    resources :a
    resources :b
    resources :c
    resources :d
    resources :e
    resources :f
    resources :g
    resources :h
    resources :rounds
    resources :responses
  end

  post 'responses/empty' => 'responses#empty'
  get 'responses/export_raw' => 'responses#export_raw_csv'
  get 'users/export_aggregate_analysis' => 'users#export_aggregate_analysis'
  resources :responses

  post ':phase/users/complete' => 'users#mark_completed'
  get 'users/stats' => 'users#stats'

  # Might need this in order to properly save users
  # since ajax call includes phase in request
  post ':phase/users(.:format)' => 'users#create'

  resources :users
  # resources :rounds

  get 'setup/payment' => 'setup#payment'
  get 'setup/available_payments' => 'setup#available_payments'
  get 'setup/experiment_options' => 'setup#experiment_options'

  # phase_two is the default option so we will redirect
  # there from the root.  
  root to: redirect('/phase_two')
  get 'phase_two' => 'phase_two/setup#experiment_options'

  # Note: This route will make all actions in
  # every controller accessible via GET requests.
  get ':controller(/:action(/:id(.:format)))'
end
