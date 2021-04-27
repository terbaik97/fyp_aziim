module Api
    module V1
        class UsersController < ApplicationController
            skip_before_action :authorize_request, only: [:create]
            def create
                
                user = User.new(signup_params)
                # user_data = Services::Auth::AuthenticateUser.call!(user.email, user.password).data
                # byebug
                if !user.save
                    return json_response(message: user.errors.full_messages, status: :unprocessable_entity)
                  end
                return_msg = "Successfully created your account"
                json_response(
                    data: user_data,
                    message: return_msg
                  )
            end

            def show
              
              user = User.where(email: params[:email])
              json_response(
                # data: user_data,
                data: user,
                message: "Successfully login"
              )
            rescue StandardError => ex
              return json_response(message: ex.message, status: :unprocessable_entity)
            end
            private
        
            def signup_params
                params.permit(
                  :email,
                  :password,
                  :nickname,
                  :full_name,
                  :mobile_number,
                  :nationality,
                )
              end
           
        end
    end
end
