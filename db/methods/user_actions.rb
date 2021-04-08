def user_action_update(user_action_hash)
    
    user = User.first
    user_id = poi_hash.dig(user.id)
    poi = Poi.first
    poi_id = user_action_hash.dig(poi.id)
    action_user = poi_hash.dig(:action_user)
    

end