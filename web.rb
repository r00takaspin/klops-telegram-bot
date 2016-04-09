require 'sinatra'
require 'redis'
require 'httparty'
require './config'


$redis = Redis.new(host: ENV["REDIS_PORT_6379_TCP_ADDR"], port: ENV["REDIS_PORT_6379_TCP_PORT"])

set :bind, '0.0.0.0'

post '/register_message' do

  secret = params[:secret]
  if SECRET == secret
    title = params[:title]
    url = params[:url]

    chat_ids = $redis.smembers(TELEGRAM_CHAT_COLLECTION)
    chat_ids.each do |chat_id|
      options = {chat_id: chat_id, text: "#{title} #{url}"}
      HTTParty.post(TELEGRAM_SEND_MESSAGE_URL, body: options)
    end

  else
    halt 'You are not authorized to register messages'
  end
end