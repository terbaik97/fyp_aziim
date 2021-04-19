module Api
    module V1
        class ImagePoiController < ApplicationController
            skip_before_action :authorize_request
            before_action :set_paper_trail_whodunnit
            def index
              all_category = Category.all()
              render json: all_category
            end

            def create

                # category = Category.new(:category_name => params[:category_name] ,:image => params[:image] )
                category = ImagePoi.new(image_poi_params)
                
                if category.valid?
                    
                    category.save
                    render json: category
                  else
                    # render json: { errors: category.errors }, status: 400
                    render_error(category.errors.full_messages[0], :unprocessable_entity)
                  end
            end

            def update
              if category.update(category_params)
                render json: category
              else
                render json: { errors: category.errors }, status: 400
              end
             
            end

            def show
             
            end

            
            private

            def find_category
              category = Category.find(params[:category_name])
            end

            def image_poi_params
                
                params.permit(
                :poi_id,
                {images: []}
                 )
            end

            
        
            

        end
    end
end
