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
    get 'show_version/:id', to: 'pois#show_version'
    get 'show/:id', to: 'pois#show'
  end
end

# resource :pois, only: [:show, :update, :destroy , :create , :index]