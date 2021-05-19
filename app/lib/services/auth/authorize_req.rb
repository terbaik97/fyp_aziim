class Services::Auth::AuthorizeReq < Services::Base
    def initialize(headers={})
      @headers = headers
    end
  
    def process
      decoded_token = JsonWebToken.decode(http_auth_header)
      user = User.find(decoded_token.dig(:user_id))
  
      if user.status != "active"
        raise ExceptionHandler::InactiveUser, "User is not active"
      end
  
      user
    rescue StandardError => se
      raise ExceptionHandler::InvalidToken, "Invalid Token"
    end
  
    private
      # The validation is against here
      attr_reader :headers
  
      def http_auth_header
        if headers["Authorization"].present?
          return headers["Authorization"].split(" ").last
        end
        
        raise ExceptionHandler::MissingToken, "Missing token"
      end
  end