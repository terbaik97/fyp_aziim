module Api
    module V1
        class PoisController < ApplicationController
            skip_before_action :authorize_request, only: [:show,:show_version]
            before_action :set_paper_trail_whodunnit
            def index
              
            end

            def create
              if request.headers["Authorization"].present?
                authorize_request
                
                
                create_poi = Poi.new(:user_id => authorize_request.id , :fields => params[:fields] , :coordinate => params[:coordinate ])
                # create_poi.user_actions.build(action_user: "create", user_id: authorize_request.id)
                if create_poi.save
                  user_action = UserAction.new(action_user: "create", user_id: authorize_request.id , poi_id: create_poi.id)
                  user_action.save
                else
                  return_msg = 'Not successfully create poi'
                  json_response(
                    message: return_msg
                  )
                end
                render json: create_poi
                
              end
              
            end

            def update
              
              update_poi = Poi.find(params[:poi_id])
              if update_poi.update(:fields => params[:fields] , :coordinate => params[:coordinate ] )
                user_action = UserAction.new(action_user: "update", user_id: authorize_request.id , poi_id: update_poi.id)
                user_action.save
                render json: update_poi
              else
                return_msg = 'Not successfully update poi'
                json_response(
                    message: return_msg
                  )
              end
            end

            def show
             
              find_poi = Poi.find(params[:id])
              if find_poi
                render json: find_poi 
              else
                return_msg = 'Not successfully find poi'
                json_response(
                    message: return_msg
                  )
              end
            end

            def show_version
             
              find_poi = Poi.find(params[:id])
              if find_poi
                render json: find_poi.versions
              else
                return_msg = 'Not successfully find poi version'
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
