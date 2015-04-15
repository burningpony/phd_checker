PhdChecker::Application.routes.draw do

  match 'a/score_card'                               => 'a#score_card'
  match 'b/score_card'                               => 'b#score_card'
  match 'c/score_card'                               => 'c#score_card'
  match 'd/score_card'                               => 'd#score_card'
  match 'e/score_card'                               => 'e#score_card'
  match 'f/score_card'                               => 'f#score_card'
  match 'g/score_card'                               => 'g#score_card'
  match 'h/score_card'                               => 'h#score_card'

  resources :a
  resources :b
  resources :c
  resources :d
  resources :e
  resources :f
  resources :g
  resources :h

  match 'responses/empty' => 'responses#empty'
  match 'responses/export_raw' => 'responses#export_raw_csv'
  match 'users/export_aggregate_analysis' => 'users#export_aggregate_analysis'
  resources :responses
  match 'users/complete' => 'users#mark_completed'
  match 'users/stats' => 'users#stats'
  resources :users
  root to: 'users#experiments'
  resources :rounds

  # Note: This route will make all actions in
  # every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
