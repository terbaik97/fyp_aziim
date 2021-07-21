module Api
    module V1
        class PoisController < ApplicationController
            skip_before_action :authorize_request, only: [:show,:show_version,:index,:show_coordinate,:show_poi,:event_poi]
            before_action :set_paper_trail_whodunnit
           
            def index
              
              poi = Poi.all();
                 json_response(
                    data: poi
                  )
              
            end

            def event_poi
              # Book.where.not(title: nil)
              poi = Poi.where.not(event: "");
                 json_response(
                    data: poi
                  )
            end

            def create
              if request.headers["Authorization"].present?
                authorize_request
                create_poi = Poi.new(
                  :user_id => authorize_request.id ,
                  :name => params[:name] , 
                  :fields => params[:fields] ,
                  :category => params[:category],
                  :poi_latitude => params[:poi_latitude ],
                  :poi_longitude => params[:poi_longitude],
                  :event => params[:event],
                  :event_date => params[:event_date]
                )
                if create_poi.save
                  user_action = UserAction.new(action_user: "create", user_id: authorize_request.id , poi_id: create_poi.id)
                  
                  if user_action.save
                    image_poi = ImagePoi.new(poi_id: create_poi.id)
                    image_poi.save
                    found(create_poi,"Succesfully create poi")
                    else
                    return_msg = 'Not successfully create poi'
                    json_response(
                    message: return_msg
                  )
                  end
                 
                  
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
              # byebug
              if  update_poi
                
                #only update exist value
                if params[:name].present?
                update_poi.update(:name => params[:name])
                end
                if params[:fields].present?
                update_poi.update(:fields => params[:fields])
                end
                if params[:poi_latitude].present?
                update_poi.update(:poi_latitude => params[:poi_latitude])
                end
                if params[:poi_longitude].present?
                update_poi.update(:poi_longitude => params[:poi_longitude])
                end
                if params[:event].present?
                  update_poi.update(:event => params[:event])
                end
                if params[:event_date].present?
                  update_poi.update(:event_date => params[:event_date])
                end
                if params[:category].present?
                  update_poi.update(:category => params[:category])
                end

                user_action = UserAction.new(action_user: "update", user_id: authorize_request.id , poi_id: update_poi.id)
                user_action.save
                found(update_poi,"Succesfully update poi")
              else
                return_msg = 'Not successfully update poi'
                json_response(
                  message: return_msg
                )
              end
            end

            def show
              
              if params.nil?
                return_msg = 'Please input which place you want to search'
                  json_response(
                    message: return_msg
                  )
              else
                check_poi_exist = Poi.where(poi_latitude: params[:poi_latitude], poi_longitude: params[:poi_longitude]).exists?
               
                if check_poi_exist
                  check_report_results = Poi.find_by(poi_latitude: params[:poi_latitude], poi_longitude: params[:poi_longitude],is_report: "1")
                  
                  if check_report_results.nil?
                    
                    results = Poi.find_by(poi_latitude: params[:poi_latitude], poi_longitude: params[:poi_longitude])
                  
                    results_image = ImagePoi.find_by(poi_id: results.id)
                    
                    render json: results.to_json(
                      :include => {
                        :image_pois => {only: [:name,:base_64,:image]}, 
                        
                      })
                  else
                    live_widget = Poi.find_by(id: check_report_results.id)
                    
                    live_widget.versions.length  
                    # @check = live_widget.paper_trail.update_columns("event") 
                    
                    if live_widget.versions.length > 2
                    widget = live_widget.paper_trail.previous_version # => widget == live_widget.versions.last.reify
                    widget1 = widget.paper_trail.previous_version      # => widget == live_widget.versions[-2].reify
                    
                    widget1.save 
                    else
                     
                      live_widget.destroy
                    
                    end
                    
                  end
                else
                  not_found(params[:name])
                end
              end
            end

            def report_item_poi_version 
           
            
              find_poi = Poi.find(params[:poi_id])  
             
              find_version_to_report = find_poi.versions.find_by(id: params[:id])
              
              if find_version_to_report
                user = User.find_by(id: params[:whodunnit])
                user.update(:user_point => user.user_point - 50)
                find_version_to_report.destroy
                json_response(
                  message: "success report"
                )
              else
                json_response(
                  message: "cannot report"
                )
              end
            end

            def revert_item_poi_version 
             
              find_poi = Poi.find(params[:poi_id])
              
              find_version_to_revert = find_poi.versions.find_by(id: params[:id])
              if find_version_to_revert
                user = User.find_by(id: params[:whodunnit])
                user.update(:user_point => user.user_point + 30)
                
                if  find_version_to_revert.object_changes['event'].present?
                  find_poi.update(:event => find_version_to_revert.object_changes['event'][1] ? find_version_to_revert.object_changes['event'][1] : '')
                end
                if  find_version_to_revert.object_changes['name'].present?
                  find_poi.update(:name => find_version_to_revert.object_changes['name'][1] ? find_version_to_revert.object_changes['name'][1] : '')
                end
                if  find_version_to_revert.object_changes['category'].present?
                  find_poi.update(:category => find_version_to_revert.object_changes['category'][1] ? find_version_to_revert.object_changes['category'][1] : '')
                end
                if find_version_to_revert.object_changes['event_date'].present?
                  find_poi.update(:event_date => find_version_to_revert.object_changes['event_date'][1] ? find_version_to_revert.object_changes['event_date'][1] : '')
                end
                if find_version_to_revert.object_changes['fields'].present?
                  find_poi.update(:fields => find_version_to_revert.object_changes['fields'][1] ? find_version_to_revert.object_changes['fields'][1] : '')
                end
                
                # find_version_to_revert.save
               
                json_response(
                  
                  message: "success revert"
                )
              else
                json_response(
                  message: "cannot revert"
                )
              end

            end

            def report_revert_item_poi_version_1
             
              find_poi = Poi.find(params[:poi_id])
              
              find_version_to_revert = find_poi.versions.find_by(id: params[:id])
              if find_version_to_revert
                user = User.find_by(id: params[:whodunnit])
                user.update(:user_point => user.user_point - 30)
                find_version_to_revert.destroy
                find_poi.destroy
                
                json_response(  
                  message: "success report and revert"
                )
              else
                json_response(
                  message: "cannot revert"
                )
              end

            end



            def show_version 
             
              find_poi = Poi.find(params[:id])
              image_poi =ImagePoi.find_by(poi_id: params[:id])
              results_user_action= Poi.find(params[:id])
              if find_poi
                   render json: find_poi.versions.to_json(
                    :include => {
                      :user => {
                        only: [:full_name,:user_point]
                      },
                      
                    })
                    # json_response(
                    #   data: {
                    #     find_poi.versions.to_json(
                    #     :include => {
                    #       :user => {
                    #         only: [:full_name,:user_point]
                    #       },
                          
                    #     }),
                    #     image_poi: image_poi
                    #   }
                    # )
                    
              else
                not_found(params[:name])
              end
            end



            def show_poi
              find_poi = Poi.find(params[:id])
              if find_poi
                render json: find_poi
              else
                not_found(params[:name])
              end
            end

            def search
              #  buat utk search
                find_poi_coordinate =Poi.by_distance(:origin => [params[:poi_latitude],params[:poi_longitude]])
                results = find_poi_coordinate.find_by(:name => params[:name])
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
            # def user_for_paper_trail
            #   current_user&.full_name 
            # end
        end
    end
end
