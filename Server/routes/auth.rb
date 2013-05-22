# http://localhost:4567/login
post '/login' do
  unless request.body.read.empty?
    request.body.rewind # because "read" method is IO thing and the unless condition is ending it
    data = JSON.parse request.body.read
  else
    status 400
    res = { message: "Request without body." }
    content_type :json
    return res.to_json
  end
  
  unless data.has_key?("username")
    status 400
    res = { message: "Missing username." }
    content_type :json
    return res.to_json
  end
  
  unless data.has_key?("password")
    status 400
    res = { message: "Missing password." }
    content_type :json
    return res.to_json
  end
  
  query = "SELECT * FROM User WHERE username='#{data["username"]}'"
  result = @@mysqlclient.query(query, as: :hash)
  results_array = Array.new
  result.each do |row|
    results_array.push(row)
  end
  
  if results_array.count == 0
   status 400
   res = { message: "That username doesn't exist."}
   content_type :json
   return res.to_json
  end
  
  user_hash = results_array[0]
  unless user_hash["password"] == data["password"]
    status 400
    res = { message: "The password is incorrect."}
    content_type :json
    return res.to_json
  end
  
  users_with_token = nil
  while users_with_token == nil
   token = SecureRandom.hex
   query = "SELECT * FROM User WHERE token='#{token}'"
   users_with_token = @@mysqlclient.query(query, as: :hash)
   
   if users_with_token.count == 0
     query =  "UPDATE User SET token='#{token}' WHERE id=#{user_hash["id"]}"
     @@mysqlclient.query(query, as: :hash)
   else
     users_with_token = nil
   end
  end
  
  query = "SELECT id, firstName, username, isAdmin, lastName, token FROM User WHERE id='#{user_hash["id"]}'"
  result = @@mysqlclient.query(query, as: :hash)
  results_array = Array.new
  result.each do |row|
    results_array.push(row)
  end
  user_hash = results_array[0]
  
  res = { message: "Logged in successfully.", user: user_hash }
  content_type :json
  res.to_json
end

# http://localhost:4567/logout
post '/logout' do
  unless request.body.read.empty?
    request.body.rewind # because "read" method is IO thing and the unless condition is ending it
    data = JSON.parse request.body.read
  else
    status 400
    res = { message: "Request without body." }
    content_type :json
    return res.to_json
  end
  
  query = "SELECT * FROM User WHERE token='#{data["token"]}'"
  result = @@mysqlclient.query(query, as: :hash)
  results_array = Array.new
  result.each do |row|
    results_array.push(row)
  end
  
  if results_array.count == 0
   status 200
   res = { message: "No user found with that token."}
   content_type :json
   return res.to_json
  end
  
  user_hash = results_array[0]
  query =  "UPDATE User SET token=NULL WHERE id=#{user_hash["id"]}"
  @@mysqlclient.query(query, as: :hash)
  
  res = { message: "Successfully logged out." }
  content_type :json
  res.to_json
  
end

# http://localhost:4567/register
post '/register' do
  
end