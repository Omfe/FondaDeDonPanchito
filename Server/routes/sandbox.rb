get '/date' do
  res = { date: DateTime.now }
  content_type :json
  res.to_json
end

post '/date' do
  # { "date": "2013-06-02T10:02:36-07:00" }
  data = JSON.parse request.body.read
  
  puts "DatA: #{data}"
  date = DateTime.parse(data["date"])
  puts "DatE: #{date}"
  
  res = { date: date }
  content_type :json
  res.to_json
end