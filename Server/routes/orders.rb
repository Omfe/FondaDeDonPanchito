# http://localhost:4567/orders
get '/orders' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  results_array = Array.new
  
  query = "SELECT * FROM fddp_Order"
  result = @@mysqlclient.query(query, as: :hash)
  result.each do |row|
    query = "SELECT * FROM fddp_Meal m INNER JOIN fddp_Meal_has_fddp_Order mo ON m.id = mo.Meal_id INNER JOIN fddp_Order o ON o.id = mo.Order_id WHERE o.id = #{row["id"]}"
    meal_result = @@mysqlclient.query(query, as: :hash)
    row["meals"] = Array.new
    meal_result.each do |meal_row|
      row["meals"].push(meal_row)
    end
    
    query = "SELECT * FROM fddp_Item i INNER JOIN fddp_Item_has_fddp_Order io ON i.id = io.Item_id INNER JOIN fddp_Order o ON o.id = io.Order_id WHERE o.id = #{row["id"]}"
    item_result = @@mysqlclient.query(query, as: :hash)
    row["items"] = Array.new
    item_result.each do |item_row|
      row["items"].push(item_row)
    end
    results_array.push(row)
  end
  
  res = { message: "Retrieved orders successfully.", orders: results_array }
  content_type :json
  res.to_json
end

# http://localhost:4567/orders/1
get '/orders/:id' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  
  results_array = Array.new
  
  query = "SELECT * FROM fddp_Order WHERE id=#{params[:id]}"
  result = @@mysqlclient.query(query, as: :hash)
  result.each do |row|
    results_array.push(row)
  end
  
  res = { message: "Retrieved order successfully.", orders: results_array }
  content_type :json
  res.to_json
end

# http://localhost:4567/orders
post '/orders' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  
  unless request.body.read.empty?
    request.body.rewind # because "read" method is IO thing and the unless condition is ending it
    data = JSON.parse request.body.read
  else
    status 400
    res = { message: "Request without body." }
    content_type :json
    return res.to_json
  end
  
  unless data.has_key?("orderNotes")
    status 400
    res = { message: "Missing orderNotes parameter." }
    content_type :json
    return res.to_json
  end
  
  unless data.has_key?("orderedAt")
    status 400
    res = { message: "Missing orderedAt parameter." }
    content_type :json
    return res.to_json
  end
  
  query = "INSERT INTO fddp_Order (orderNotes, orderedAt) VALUES('#{data["orderNotes"]}', '#{data["orderedAt"]}')"
  puts query
  @@mysqlclient.query(query, as: :hash)
  orderId = @@mysqlclient.last_id
  
  if data.has_key?("mealIds")
    data["mealIds"].each do |mealId|
      query = "INSERT INTO fddp_Meal_has_fddp_Order (Meal_id, Order_id) VALUES(#{mealId}, #{orderId})"
      @@mysqlclient.query(query, as: :hash)
    end    
  end
  
  if data.has_key?("itemIds")
    data["itemIds"].each do |itemId|
      query = "INSERT INTO fddp_Item_has_fddp_Order (Item_id, Order_id) VALUES(#{itemId}, #{orderId})"
      @@mysqlclient.query(query, as: :hash)
    end    
  end

  res = { message: "Created order successfully." }
  content_type :json
  res.to_json
end

# http://localhost:4567/orders/1
put '/orders/:id' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  
  unless request.body.read.empty?
    request.body.rewind # because "read" method is IO thing and the unless condition is ending it
    data = JSON.parse request.body.read
  else
    status 400
    res = { message: "Request without body." }
    content_type :json
    return res.to_json
  end
  
  fields = Array.new
  
  if data.has_key?("orderNotes")
    fields.push("orderNotes='#{data["orderNotes"]}'")
  end
  
  if data.has_key?("orderedAt")
    fields.push("orderedAt='#{data["orderedAt"]}'")
  end
  
  if fields.count > 0
    query = "UPDATE fddp_Order SET #{fields.join(", ")} WHERE id=#{params[:id]}"
    @@mysqlclient.query(query, as: :hash)
  end
  
  res = { message: "Updated order successfully." }
  content_type :json
  res.to_json
end

# http://localhost:4567/orders/1
delete '/orders/:id' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  
  query = "DELETE FROM fddp_Meal_has_fddp_Order WHERE Order_id=#{params[:id]}"
  @@mysqlclient.query(query, as: :hash)
  
  query = "DELETE FROM fddp_Order WHERE id=#{params[:id]}"
  @@mysqlclient.query(query, as: :hash)
  
  res = { message: "Deleted order successfully." }
  content_type :json
  res.to_json
end
