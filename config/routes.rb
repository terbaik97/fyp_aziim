def load_route(name)
  instance_eval Rails.root.join("config/routes/#{name}.rb").read
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      load_route 'api/v1'
    end
  end
end
