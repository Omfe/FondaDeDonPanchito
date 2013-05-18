require "rubygems"
require "json"
require "mysql2"
require "sinatra"

@@mysqlclient = Mysql2::Client.new(host: "localhost", username: "root", database: "FondadeDonPanchito")

load "routes/auth.rb"
load "routes/index.rb"
load "routes/items.rb"
load "routes/meals.rb"