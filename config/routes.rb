PhdChecker::Application.routes.draw do
  root to: redirect('/phase_two')

  get 'phase_two' => 'setup#experiment_options', defaults: {phase: 'phase_two'}
  get 'phase_one' => 'setup#experiment_options', defaults: {phase: 'phase_one'}

  post 'responses/empty'      => 'responses#empty'
  get  'responses/export_raw' => 'responses#export_raw_csv'

  get  'users/export_aggregate_analysis' => 'users#export_aggregate_analysis'
  get  'users/stats'                     => 'users#stats'

  resources :users

  scope '(:phase)' do
    get 'a/score_card' => 'a#score_card'
    get 'b/score_card' => 'b#score_card'
    get 'c/score_card' => 'c#score_card'
    get 'd/score_card' => 'd#score_card'
    get 'e/score_card' => 'e#score_card'
    get 'f/score_card' => 'f#score_card'
    get 'g/score_card' => 'g#score_card'
    get 'h/score_card' => 'h#score_card'

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

    post 'users/complete'  => 'users#mark_completed'
    post 'users(.:format)' => 'users#create'
  end

  get 'setup/payment'            => 'setup#payment'
  get 'setup/available_payments' => 'setup#available_payments'
  get 'setup/experiment_options' => 'setup#experiment_options'
  
  # Note: This route will make all actions in
  # every controller accessible via GET requests.
  get ':controller(/:action(/:id(.:format)))'
end
