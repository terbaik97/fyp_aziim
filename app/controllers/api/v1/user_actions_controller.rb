module Api
    module V1
        class UserActionsController < ApplicationController
          skip_before_action :authorize_request, only: [:user_data]
          def user_action
            # user =  UserAction.where(user_id: params[:user_id]) 
            # find_poi = Poi.find(params[:])
            user = PaperTrail::PoiVersion.where(whodunnit: params[:user_id]) 
            # render json: user.to_json(
            #   :include => {
            #     :poi => {
            #       only: [:name]
            #     }
            #     # :data => PaperTrail::PoiVersion(whodunnit: params[:user_id]) ,

                
            #   })
            json_response(
              data: user,
              message: "Success"
            )
          end

          def user_action_create
            user =  UserAction.where(user_id: params[:user_id],action_user: 'create') 
            json_response(
              data: user,
              message: "Success"
            )
          end

          def user_action_update
            user =  UserAction.where(user_id: params[:user_id],action_user: 'update') 
            # byebug
            json_response(
              data: user,
              message: "Success"
            )
          end

          def user_action_report
            user =  UserAction.where(user_id: params[:user_id],action_user: 'report') 
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

          def user_data
            user = User.all()
           
            json_response(
              data: user,
              message: "Success"
            )
          end
        end
    end
end
