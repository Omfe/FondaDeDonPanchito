require "rubygems"
require "json"
require "mysql2"
require "sinatra"

@@mysqlclient = Mysql2::Client.new(host: "localhost", username: "root", database: "FondadeDonPanchito")

def verifyLoggedIn
  puts "Testing"
  
  query = "SELECT * FROM User WHERE token='#{data["token"]}'"
  result = @@mysqlclient.query(query, as: hash)
  results_aray = Array.new
  result.each do |row|
    results_array.push(row)
  end
  
  if results_array.count == 0
    status 400
    res = {message:"That username doesn't exist."}
    content_type :json
    return res.to_json
  end
end

load "routes/auth.rb"
load "routes/index.rb"
load "routes/items.rb"
load "routes/meals.rb"

#hacer un select en la base de datos, si te regresa 0 cosas, manda ahí mismo en ese método el response con error parecido al del login