before do
  content_type :json
  response['Access-Control-Allow-Origin'] = '*'
end

get '/' do
  Redisify.recover_cache("data", $config.cache_sec_duration) do
    miner = Miner.new
    miner.mine
    miner.data.to_json
  end
end
