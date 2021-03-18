post "/login", to: "auth#login"
post "/sign-up", to: "auth#sign_up"
post "/create", to: "users#create"

resources :app_configs, only: [] do
  collection do
    get :initial
  end
end