module Serializers::Poi::Show
    class << self
      def hash(poi)
        {
          
          name: poi.name,
          coordinate: poi.coordinate,
          user_id: poi.user_id,
          created_at: poi.created_at,
          fields: poi.fields

      }
      end
    end
  end