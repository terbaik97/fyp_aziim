def category_update(category_hash)

    category_name = category_hash.dig(:category_name)
    image= category_hash.dig(:image)
    log("Adding user: #{category_name} ...")

   categories = Category.where(category_name: category_name)

    if categories.blank?
      category = Category.new
    else
      category = categories.last
    end

    category.attributes = category_hash
    if !category.save
      raise category.errors.messages.to_json
    end
    category.reload

  

    return category
  end