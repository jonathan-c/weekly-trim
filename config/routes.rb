WeeklyTrim::Application.routes.draw do

  namespace :admin do
    match 'mailer(/:action(/:id(.:format)))' => 'mailer#:action'
  end

  get "users/edit"

  get "users/update"

  resources :groups, :except => [:index] do
    resources :users, :only => [:edit, :update]
    resources :posts
  end
  
  # match '/join-group' => 'groups#join'
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
  delete "/join_groups/destroy"
  
  match "/welcome" => "pages#welcome"
  match "/pages/no_access" => "pages#no_access"
  match "/auth/:provider" => redirect("http://#{DOMAIN_NAME}/auth/#{:provider}"), :as => :signin
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout
  
  root :to => 'pages#index'

end
