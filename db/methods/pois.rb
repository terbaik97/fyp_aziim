def poi_update(poi_hash)
   
    user = User.first
    user_id = poi_hash.dig(user.id)
    name = poi_hash.dig(:name)
    category = Category.first
    subcategory_id = poi_hash.dig(category.id)
    fields = poi_hash.dig(:fields)
    coordinate = poi_hash.dig(:coordinate)
    log("Adding poi: #{fields } ...")

    poi = Poi.where(name: name)

    if poi.blank?
      poi = Poi.new
    else
        return poi
    end

    

  

 
  end