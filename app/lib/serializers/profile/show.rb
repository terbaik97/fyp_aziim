module Serializers::Profile::Show
    class << self
      def hash(data)
        return if data.blank?
        
        {
          id: data.id,
          nickname: data.nickname,
          full_name: data.full_name,
          email: data.email,
          mobile_number: data.mobile_number,
          nationality: data.nationality,
          status: data.status,
          is_verified_mobile_number: data.is_verified_mobile_number,
          is_verified_email: data.is_verified_email 
        }.compact
      end
    end
  end