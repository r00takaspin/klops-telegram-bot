require 'sinatra'
require 'redis'
require 'httparty'
require 'erb'
require 'sinatra/basic_auth'
require './config'

$redis = Redis.new(host: ENV['REDIS_PORT_6379_TCP_ADDR'], port: ENV['REDIS_PORT_6379_TCP_PORT'])

set :bind, '0.0.0.0'

authorize do |username, password|
  username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
end

protect do
  get '/' do
    erb :new_message
  end
end

post '/register_message' do
  secret = params[:secret]
  if SECRET == secret
    title = params[:title]
    url = params[:url]

    chat_ids = $redis.smembers(TELEGRAM_CHAT_COLLECTION)
    chat_ids.each do |chat_id|
      options = { chat_id: chat_id, text: "#{title} #{url}" }
      HTTParty.post(TELEGRAM_SEND_MESSAGE_URL, body: options)
    end
    'ok'
  else
    halt 'You are not authorized to register messages'
  end
end
