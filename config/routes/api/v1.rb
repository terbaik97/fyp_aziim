post "/login", to: "auth#login"
post "/sign-up", to: "auth#sign_up"
post "/create", to: "users#create"


resources :app_configs, only: [] do
  collection do
    get :initial
  end
end

resources :pois, only: [] do
  collection do
    get :index
    post :create
    put 'update'
    get 'show_version/:name', to: 'pois#show_version'
    get 'show', to: 'pois#show'
  end
end

resources :category