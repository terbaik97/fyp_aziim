module Api
    module V1
        class PoisController < ApplicationController
            skip_before_action :authorize_request, only: [:show,:show_version,:index]
            before_action :set_paper_trail_whodunnit
           
            def index
              find_poi_coordinate =Poi.by_distance(:origin => [params[:poi_latitude],params[:poi_longitude]])
              # byebug
              results = find_poi_coordinate.where(:name => params[:name])
              json_response(
               data: results
              )
              
            end

            def create
              if request.headers["Authorization"].present?
                authorize_request
                create_poi = Poi.new(:user_id => authorize_request.id ,:name => params[:name] , :fields => params[:fields] , :coordinate => params[:coordinate ])
                if create_poi.save
                  user_action = UserAction.new(action_user: "create", user_id: authorize_request.id , poi_id: create_poi.id)
                  user_action.save
                  found(create_poi)
                else
                  return_msg = 'Not successfully create poi'
                  json_response(
                    message: return_msg
                  )
                end
              end
            end

            def update
              update_poi = Poi.find(params[:poi_id])
              if update_poi.update(:fields => params[:fields] , :coordinate => params[:coordinate ] )
                user_action = UserAction.new(action_user: "update", user_id: authorize_request.id , poi_id: update_poi.id)
                user_action.save
                # render json: update_poi
                found(update_poi)
              else
                # render_error(update_poi.errors.full_messages[0], :unprocessable_entity)
                not_found(params[:poi_id])
              end
            end

            def show
              
              if params.nil?
                return_msg = 'Please input which place you want to search'
                  json_response(
                    message: return_msg
                  )
              else
               
                find_poi_coordinate =Poi.by_distance(:origin => [params[:poi_latitude],params[:poi_longitude]])
                results = find_poi_coordinate.find_by(:name => params[:name])
                if results
                  render json: results
                else
                  not_found(params[:name])
                end
              end
            end

            def show_version
              find_poi = Poi.find(params[:name])
              if find_poi
                byebug
                json_response(
                  data: Serializers::Poi::Show.hash(find_poi)
                )  
              else
                not_found(params[:name])
              end
            end

            private
            def poi_params 
                params.permit(
                  :fields,
                  :coordinate 
                )
            end
            def not_found(name)
              render json: {
                error: "Place with id #{params[:name]} not found."
              }, status: :not_found
            end
            def found(find_poi)
              json_response(
                  data: Serializers::Poi::Show.hash(find_poi)
                )  
            end
        end
    end
end
