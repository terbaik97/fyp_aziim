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

            def update
              
              user = User.find_by(id: params[:id])
            
              if  user
                  if params[:email].present?
                    user.update(:email => params[:email])
                  end
                  if params[:mobile_number].present?
                    user.update(:mobile_number => params[:mobile_number])
                  end
                  if params[:full_name].present?
                    user.update(:full_name => params[:full_name])
                  end
                  if params[:avatar].present?
                    user.update(:avatar => params[:avatar])
                  end
                  if params[:user_point].present?
                    user.update(:user_point => params[:user_point])
                  end
                  json_response(
                  data: user,
                  message: "Successfully update profile"
                  )
            else 
              json_response(
                data: "",
                message: "Unsuccessfully update profile"
                )
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
          end
        end
    end

