# http://localhost:4567/meals
get '/meals' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  results_array = Array.new
  
  query = "SELECT * FROM fddp_Meal"
  result = @@mysqlclient.query(query, as: :hash)
  result.each do |row|
    results_array.push(row)
  end
  
  res = { message: "Retrieved meals successfully.", meals: results_array }
  content_type :json
  res.to_json
end

# http://localhost:4567/meals/1
get '/meals/:id' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  
  results_array = Array.new
  
  query = "SELECT * FROM fddp_Meal WHERE id=#{params[:id]}"
  result = @@mysqlclient.query(query, as: :hash)
  result.each do |row|
    results_array.push(row)
  end
  
  res = { message: "Retrieved meal successfully.", meals: results_array }
  content_type :json
  res.to_json
end

# http://localhost:4567/meals
post '/meals' do
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
  
  unless data.has_key?("mealName")
    status 400
    res = { message: "Missing mealName parameter." }
    content_type :json
    return res.to_json
  end
  
  unless data.has_key?("mealPrice")
    status 400
    res = { message: "Missing mealPrice parameter." }
    content_type :json
    return res.to_json
  end
  
  unless data.has_key?("isActive")
    status 400
    res = { message: "Missing isActive parameter." }
    content_type :json
    return res.to_json
  end
  
  query = "INSERT INTO fddp_Meal (mealName, mealPrice, isActive) VALUES('#{data["mealName"]}', #{data["mealPrice"]}, #{data["isActive"]})"
  @@mysqlclient.query(query, as: :hash)
  mealId = @@mysqlclient.last_id
  
  if data.has_key?("itemIds")
    data["itemIds"].each do |itemId|
      query = "INSERT INTO fddp_Item_has_fddp_Meal (Item_id, Meal_id) VALUES(#{itemId}, #{mealId})"
      @@mysqlclient.query(query, as: :hash)
    end    
  end

  res = { message: "Created meal successfully." }
  content_type :json
  res.to_json
end

# http://localhost:4567/meals/1
put '/meals/:id' do
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
  
  if data.has_key?("mealName")
    fields.push("mealName='#{data["mealName"]}'")
  end
  
  if data.has_key?("mealPrice")
    fields.push("mealPrice=#{data["mealPrice"]}")
  end
  
  if data.has_key?("isActive")
    fields.push("isActive=#{data["isActive"]}")
  end
  
  if fields.count > 0
    query = "UPDATE fddp_Meal SET #{fields.join(", ")} WHERE id=#{params[:id]}"
    @@mysqlclient.query(query, as: :hash)
  end
  
  res = { message: "Updated meal successfully." }
  content_type :json
  res.to_json
end

# http://localhost:4567/meals/1
delete '/meals/:id' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  
  query = "DELETE FROM fddp_Item_has_fddp_Meal WHERE Meal_id=#{params[:id]}"
  @@mysqlclient.query(query, as: :hash)
  
  query = "DELETE FROM fddp_Meal WHERE id=#{params[:id]}"
  @@mysqlclient.query(query, as: :hash)
  
  res = { message: "Deleted meal successfully." }
  content_type :json
  res.to_json
end
