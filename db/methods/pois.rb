def poi_update(poi_hash)
    user_id: "",
    name: "Kafeteria",
    subcategory_id: "",
    fields: {
    "rating" : 4.5,
    "website" : "https://www.google.com/imghp?hl=EN",
    "address" : "Baktisiswa, 50603 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
    "phone_number" : "(02) 9374 4000"},
    coordinate: "3.1189135014848364, 101.65991838090626",
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