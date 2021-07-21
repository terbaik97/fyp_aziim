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
    get :event_poi
    post :create
    put 'update'
    get 'show_version/:id', to: 'pois#show_version'
    get 'show', to: 'pois#show'
    get 'show_poi/:id', to: 'pois#show_poi'
    get 'show/coordinate', to: 'pois#show_coordinate'
    post 'show/poi-item-report', to: 'pois#report_item_poi_version'
    post 'show/poi-item-revert', to: 'pois#revert_item_poi_version'
    post 'show/poi-item-report-revert-1', to: 'pois#report_revert_item_poi_version_1'
    
  end
end

resources :category

resources :image_poi

resources :report

get "/user_actions", to: "user_actions#user_action"
get "/user_actions_create", to: "user_actions#user_action_create"
get "/user_actions_update", to: "user_actions#user_action_update"
get "/user_actions_report", to: "user_actions#user_action_report"
get "/user_data", to: "user_actions#user_data"
put "/user_point", to: "user_actions#user_point"
put "/user_point/add", to: "user_actions#add_user_point"
put "/user_point/subtract", to: "user_actions#subtract_user_point"