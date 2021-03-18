def user_update(user_hash, role_name=nil)
    email = user_hash.dig(:email)
    mobile_number = user_hash.dig(:mobile_number)
    log("Adding user: #{email} ...")

    users = User.where(email: email)

    if users.blank?
      user = User.new
    else
      user = users.last
    end

    user.attributes = user_hash
    if !user.save
      raise user.errors.messages.to_json
    end
    user.reload

    if role_name.present?
      user.add_role role_name
    end

    return user
  end