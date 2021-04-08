module Api
    module V1
        class CategoryController < ApplicationController
            skip_before_action :authorize_request
            before_action :set_paper_trail_whodunnit
            def index
              all_category = Category.all()
              render json: all_category
            end

            def create

                # category = Category.new(:category_name => params[:category_name] ,:image => params[:image] )
                category = Category.new(category_params)
                if category.valid?
                    # post_serializer = PostS erializer.new(post: @post, user: @user)
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

            def category_params 
                
                params.permit(
                :category_name,
                :image
                 )
            end

            
        
            

        end
    end
end
