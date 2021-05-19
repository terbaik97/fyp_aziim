module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authorize_request

      def sign_up
    
        if params[:password_confirm] != params[:password]
          raise ExceptionHandler::AuthError, "Password do not match"
        end

        user = User.new(signup_params)

        if !user.save
          return json_response(message: user.errors.full_messages, status: :unprocessable_entity)
        end
        
        login("Account created")
      end

      def login(msg='')
        
        begin
          user_data = Services::Auth::AuthenticateUser.call!(login_params[:email], login_params[:password]).data
          return_msg = msg.present? ? msg : 'Successfully logged in'

          json_response(
            data: user_data ,
            message: return_msg
          )
        rescue StandardError => ex
          return json_response(message: ex.message, status: :unprocessable_entity)
        end
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

        def login_params
          params.permit(:email, :password)
        end
    end
  end
end
