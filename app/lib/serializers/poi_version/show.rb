module Serializers::PoiVersion::Show
    class << self
      def hash(poi)
        {
          
            # created_at: poi.length
            # event: poi.event,
            # object_changes: {
            #     name:poi.name,
            #     fields:poi.fields,
            #     subcategory_id:poi.subcategory_id
            # }
            # ,
            # user_made_change: poi.user_id,
            # x = poi.length

            for i in 0..poi.length do
              puts "Value of local variable is #{i}"
            end

      }
      for i in 0..poi.length do
        puts "Value of local variable is #{i}"
      end
      end
    end
  end