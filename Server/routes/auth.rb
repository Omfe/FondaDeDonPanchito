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
  
  query = "SELECT * FROM User WHERE username=#{data["username"]}"
  result = @@mysqlclient.query(query, as: :hash)
  results_array = Array.new
  result.each do |row|
    results_array.push(row)
  end
  
  # 1. Checar que el arreglo contenga un usuario
  # 2. Checar que el usuario tenga la misma clave que el data["password"]
  # 3. Generar token único y guardarlo en el usuario (esto implica un query)
  # 4. Regresar message y token en el response
  
  res = { message: "Logged in successfully.", token: null }
  content_type :json
  res.to_json
end

# http://localhost:4567/logout
post '/logout' do
  
end

# http://localhost:4567/register
post '/register' do
  
end