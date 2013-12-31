before do
  content_type :json
  response['Access-Control-Allow-Origin'] = '*'
end

get '/' do
end
