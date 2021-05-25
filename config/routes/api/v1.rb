post "/login", to: "auth#login"
post "/sign-up", to: "auth#sign_up"
post "/create", to: "users#create"
put "/update", to: "users#update"
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
    get 'show_poi/:id', to: 'pois#show_poi'
    get 'show/coordinate', to: 'pois#show_coordinate'
  end
end

resources :category

resources :image_poi

resources :report

get "/user_actions", to: "user_actions#user_action"
put "/user_point", to: "user_actions#user_point"
put "/user_point/add", to: "user_actions#add_user_point"
put "/user_point/subtract", to: "user_actions#subtract_user_point"