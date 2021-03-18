module ExceptionHandler
    extend ActiveSupport::Concern
  
    # Define custom error subclasses - rescue catches `StandardErrors`
    class AuthError < StandardError; end
    class MissingToken < StandardError; end
    class InactiveUser < StandardError; end
    class InvalidToken < StandardError; end
    
    included do
      # Define custom handlers
      # rescue_from StandardError, with: :unprocessable_entity_request
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_request
      # rescue_from ExceptionHandler::UnknownError, with: :unprocessable_entity_request
      rescue_from ExceptionHandler::AuthError, with: :unprocessable_entity_request
      rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity_request
      rescue_from ExceptionHandler::InactiveUser, with: :unprocessable_entity_request
      rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity_request
      # rescue_from ExceptionHandler::ExpiredSignature, with: :unauthorized_request
      # rescue_from ExceptionHandler::DecodeError, with: :unauthorized_request
      # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      # rescue_from ExceptionHandler::ComingSoon, with: :coming_soon_request
    end
  
    private
      def record_not_found(ex)
        json_response(
          message: get_msg(ex),
          status: :not_found
        )
      end
  
      # JSON response with message; Status code 422 - unprocessable entity
      def unprocessable_entity_request(ex)
        json_response(
          message: get_msg(ex),
          status: :unprocessable_entity
        )
      end
  
      # JSON response with message; Status code 401 - Unauthorized
      def unauthorized_request(ex)
        json_response(
          message: get_msg(ex),
          status: :unauthorized
        )
      end
  
      # def coming_soon_request(ex)
      #   json_response(
      #     message: get_msg(ex),
      #     status: 452 # coming soon
      #   )
      # end
  
      private
        def get_msg(ex)
          begin
            return JSON.parse(ex.message)
          rescue
            return ex.message
          end
        end
  end
  