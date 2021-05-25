module Api
    module V1
        class ReportController < ApplicationController
            skip_before_action :authorize_request, only: [:show,:show_version,:index,:show_coordinate]
            before_action :set_paper_trail_whodunnit
           
            def index
             
            end

            def create
                
            end

            def update
              if request.headers["Authorization"].present?
                authorize_request
                if params[:poi_id].empty?
                  return_msg = 'Unsuccessfully report poi'
                  json_response(
                    message: return_msg
                  )
                else
                  update_poi = Poi.find(params[:poi_id])
                  if update_poi.update(
                      is_report: "1",
                      report_reason: params[:report_reason])
                      user_action = UserAction.new(action_user: "report", user_id: authorize_request.id , poi_id: update_poi.id)
                      user_action.save
                       render json: update_poi
                  else
                    return_msg = 'fail to save a report poi'
                    json_response(
                      message: return_msg
                    )
                  end
                end
              end
            end

            def show
              
              
            end

          

            def show_version 
             
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
            def found(find_poi,message)
              json_response(
                  data: Serializers::Poi::Show.hash(find_poi),
                  message: message
                )  
            end
            def user_for_paper_trail
              current_user&.full_name 
            end
        end
    end
end
