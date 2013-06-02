require "rubygems"
require "json"
require "mysql2"
require "sinatra"

@@mysqlclient = Mysql2::Client.new(host: "localhost", username: "root", database: "FondadeDonPanchito")

def verifyLoggedIn
  unless params.has_key?("token")
    return "Missing token."
  end
  
  query = "SELECT * FROM User WHERE token='#{params["token"]}'"
  result = @@mysqlclient.query(query, as: hash)
  results_array = Array.new
  result.each do |row|
    results_array.push(row)
  end
  
  if results_array.count == 0
    return "Not authorized!"
  end
end

load "routes/auth.rb"
load "routes/index.rb"
load "routes/items.rb"
load "routes/meals.rb"
load "routes/orders.rb"

load "routes/sandbox.rb"
