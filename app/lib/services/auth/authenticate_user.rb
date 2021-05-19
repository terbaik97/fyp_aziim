class Services::Auth::AuthenticateUser < Services::Base
    validates :email, presence: :true
    validates :password, presence: :true
  
    def initialize(email, password)
      @email = email
      @password = password
    end
  
    def process
      user = User.find_by(email: @email)
  
      if user.blank?
        raise ExceptionHandler::AuthError, "Invalid login"
      end
  
      if user.authenticate(@password)
        two_weeks_from_now = Time.now + 2.week # This have to be in a string format (eg: 2019-03-20 18:01:44 +0800). Can't be in number (https://github.com/jwt/ruby-jwt/issues/148)
  
        return Serializers::Auth::AuthenticateUser.hash(user, two_weeks_from_now)
      end
  
      msg = "Invalid Credentials"
      # raise Authentication error if credentials are invalid
      raise(ExceptionHandler::AuthError, msg)
    end
  
    private
      # The validation is against here
      attr_reader :email, :password, :auth_info
  end