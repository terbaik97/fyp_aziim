post "/login", to: "auth#login"
post "/sign-up", to: "auth#sign_up"
post "/create", to: "users#create"
get "/show", to: "users#show"


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
    get 'show', to: 'pois#show'
    get 'show/coordinate', to: 'pois#show_coordinate'
  end
end

resources :category

resources :image_poi