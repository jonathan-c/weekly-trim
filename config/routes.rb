WeeklyTrim::Application.routes.draw do

  namespace :admin do
    match 'mailer(/:action(/:id(.:format)))' => 'mailer#:action'
  end

  resources :groups, :except => [:index] do
    resources :users, :only => [:edit, :update]
    resources :posts
  end
  
  get '/join-group/:token' => 'groups#join', :as => :join_group

  get "sessions/create"

  get "pages/home"
  get "pages/welcome"
  get "pages/no_access"
  get "pages/ask_for_email"
  get "pages/update_email"
  get "pages/dispatcher"
  
  post "groups/email"
  
  post "/join_groups/create"
  post "/join_groups/destroy"
  
  match "/welcome" => "pages#welcome"
  match "/auth/:provider" => redirect("http://#{DOMAIN_NAME}/auth/#{:provider}"), :as => :signin
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout
  
  root :to => 'pages#index'

end
