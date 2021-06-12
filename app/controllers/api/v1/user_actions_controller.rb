module Api
    module V1
        class UserActionsController < ApplicationController

          def user_action
            user =  UserAction.where(user_id: params[:user_id]) 
            json_response(
              data: user,
              message: "Success"
            )
          end

          def user_point
            user = User.find_by(id: params[:id])
            
            if user
              if params[:user_point].present?
                user.update(:user_point => params[:user_point].to_i)
                end
                json_response(
                  message: "Successfully update point",
                  data: user
                )
            else
              json_response(
                message: "Not successfully update point"
              )
            end

          end

          def add_user_point
            user = User.find_by(id: params[:id])

            if user
              if params[:user_point].present?
                user.update(:user_point => user.user_point + params[:user_point].to_i)
                end
                json_response(
                  message: "Successfully update point",
                  data: user
                )
            else
              json_response(
                message: "Not successfully update point"
              )
            end

          end

          def subtract_user_point
            user = User.find_by(id: params[:id])

            if user
              if params[:user_point].present?
                user.update(:user_point => user.user_point - params[:user_point].to_i)
                end
                json_response(
                  message: "Successfully update point",
                  data: user
                )
            else
              json_response(
                message: "Not successfully update point"
              )
            end

          end

        end
    end
end
