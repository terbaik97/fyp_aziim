module Api
    module V1
        class ImagePoiController < ApplicationController
            skip_before_action :authorize_request
            before_action :set_paper_trail_whodunnit
            def index
              all_image = PoiImage.all()
              render json: all_image
            end

            def create

                image = ImagePoi.new(image_poi_params)

                if image.valid?
                    image.save
                    render json: image
                  else
                    render_error(image.errors.full_messages[0], :unprocessable_entity)
                  end
            end

            def update
              
                image_poi = ImagePoi.find_by(poi_id: params[:poi_id])
                
              if image_poi.update(image_poi_params)

                render json: image_poi
              else
                render json: { errors: image_poi.errors }, status: 400
              end
            end

            def show
             
            end

            
            private

            def find_category
              image = ImagePoi.find(params[:poi_id])
            end

            def image_poi_params
                
                params.permit(
                :poi_id,
                :name,
                :size,
                :image,
                
                 )
            end
         
            
        
            

        end
    end
end
