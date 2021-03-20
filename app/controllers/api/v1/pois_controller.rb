module Api
    module V1
        class PoisController < ApplicationController
            skip_before_action :authorize_request

            def create
              if request.headers["Authorization"].present?
                authorize_request
                user_action = UserAction.new(action_user: "created", user_id: authorize_request.id)
                create_poi = Poi.new(:user_id => authorize_request.id , :fields => params[:fields] , :coordinate => params[:coordinate ])
                
                if !user_action.save
                  return json_response(message: user_action.errors.full_messages, status: :unprocessable_entity)
                end
                if !create_poi.save
                  return json_response(message: create_poi.errors.full_messages, status: :unprocessable_entity)
                end
                return_msg = 'Successfully created poi'
                json_response(
                    message: return_msg
                  )
                
              end
              
            end

            def update
              user_action = UserAction.new(action_user: "update", user_id: authorize_request.id)
              update_poi = Poi.find(params[:poi_id])
              
              if update_poi.update(:fields => params[:fields] , :coordinate => params[:coordinate ] )
                render json: update_poi
              else
                return_msg = 'Successfully created poi'
                json_response(
                    message: return_msg
                  )
              end
            end

            private
        
            def poi_params 
                
                params.permit(
                  :fields,
                  :coordinate 
                )
              end
        end
    end
end
