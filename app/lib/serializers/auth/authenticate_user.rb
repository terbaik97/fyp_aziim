module Serializers::Auth::AuthenticateUser
    class << self
      def hash(user, token_expire_at)
        {
          user: {
            id: user.id,
            nickname: user.nickname,
            full_name: user.full_name,
            email: user.email,
            mobile_number: user.mobile_number,
            nationality: user.nationality,
            status: user.status,
            is_verified_mobile_number: user.is_verified_mobile_number,
            is_verified_email: user.is_verified_email
          },
          access_token: {
            jwt: JsonWebToken.encode({ user_id: user.id }, token_expire_at),
            expire_at: token_expire_at
          }
        }
      end
    end
  end