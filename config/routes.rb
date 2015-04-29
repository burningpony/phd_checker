PhdChecker::Application.routes.draw do

  get 'a/score_card'                               => 'a#score_card'
  get 'b/score_card'                               => 'b#score_card'
  get 'c/score_card'                               => 'c#score_card'
  get 'd/score_card'                               => 'd#score_card'
  get 'e/score_card'                               => 'e#score_card'
  get 'f/score_card'                               => 'f#score_card'
  get 'g/score_card'                               => 'g#score_card'
  get 'h/score_card'                               => 'h#score_card'

  resources :a
  resources :b
  resources :c
  resources :d
  resources :e
  resources :f
  resources :g
  resources :h

  post 'responses/empty' => 'responses#empty'
  get 'responses/export_raw' => 'responses#export_raw_csv'
  get 'users/export_aggregate_analysis' => 'users#export_aggregate_analysis'
  resources :responses
  post 'users/complete' => 'users#mark_completed'
  get 'users/stats' => 'users#stats'
  resources :users
  root to: 'users#experiments'
  resources :rounds

  # Note: This route will make all actions in
  # every controller accessible via GET requests.
  get ':controller(/:action(/:id(.:format)))'
end
