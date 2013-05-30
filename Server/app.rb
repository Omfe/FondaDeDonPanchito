require "rubygems"
require "json"
require "mysql2"
require "sinatra"

@@mysqlclient = Mysql2::Client.new(host: "localhost", username: "root", database: "FondadeDonPanchito")

def verifyLoggedIn
  puts "Testing"
end

load "routes/auth.rb"
load "routes/index.rb"
load "routes/items.rb"
load "routes/meals.rb"