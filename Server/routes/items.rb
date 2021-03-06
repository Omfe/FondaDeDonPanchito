# http://localhost:4567/items
get '/items' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  results_array = Array.new
  
  query = "SELECT * FROM fddp_Item"
  result = @@mysqlclient.query(query, as: :hash)
  result.each do |row|
    results_array.push(row)
  end
  
  res = { message: "Retrieved items successfully.", items: results_array }
  content_type :json
  res.to_json
end

# http://localhost:4567/items/1
get '/items/:id' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  results_array = Array.new
  
  query = "SELECT * FROM fddp_Item WHERE id=#{params[:id]}"
  result = @@mysqlclient.query(query, as: :hash)
  result.each do |row|
    results_array.push(row)
  end
  
  res = { message: "Retrieved item successfully.", items: results_array }
  content_type :json
  res.to_json
end

# http://localhost:4567/items
post '/items' do
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
  
  unless data.has_key?("itemName")
    status 400
    res = { message: "Missing itemName parameter." }
    content_type :json
    return res.to_json
  end
  
  unless data.has_key?("itemPrice")
    status 400
    res = { message: "Missing itemPrice parameter." }
    content_type :json
    return res.to_json
  end
  
  unless data.has_key?("isActive")
    status 400
    res = { message: "Missing isActive parameter." }
    content_type :json
    return res.to_json
  end
  
  query = "INSERT INTO fddp_Item (itemName, itemPrice, isActive) VALUES('#{data["itemName"]}', #{data["itemPrice"]}, #{data["isActive"]})"
  @@mysqlclient.query(query, as: :hash)
  
  res = { message: "Created item successfully." }
  content_type :json
  res.to_json
end

# http://localhost:4567/items/1
put '/items/:id' do
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
  
  if data.has_key?("itemName")
    fields.push("itemName='#{data["itemName"]}'")
  end
  
  if data.has_key?("itemPrice")
    fields.push("itemPrice=#{data["itemPrice"]}")
  end
  
  if data.has_key?("isActive")
    fields.push("isActive=#{data["isActive"]}")
  end
  
  if fields.count > 0
    query = "UPDATE fddp_Item SET #{fields.join(", ")} WHERE id=#{params[:id]}"
    @@mysqlclient.query(query, as: :hash)
  end
  
  res = { message: "Updated item successfully." }
  content_type :json
  res.to_json
end

# http://localhost:4567/items/1
delete '/items/:id' do
  message = verifyLoggedIn
  if message
    status 400
    res = { message: message }
    content_type :json
    return res.to_json
  end
  
  query = "DELETE FROM fddp_Item_has_fddp_Meal WHERE Item_id=#{params[:id]}"
  @@mysqlclient.query(query, as: :hash)
  
  query = "DELETE FROM fddp_Item WHERE id=#{params[:id]}"
  @@mysqlclient.query(query, as: :hash)
  
  res = { message: "Deleted item successfully." }
  content_type :json
  res.to_json
end
