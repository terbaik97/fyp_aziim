module Serializers::Poi::Show
    class << self
      def hash(poi)
        {
          
          name: poi.name,
          poi_latitude: poi.poi_latitude,
          poi_longitude: poi.poi_longitude,
          user_id: poi.user_id,
          created_at: poi.created_at,
          fields: poi.fields

      }
      end
    end
  end