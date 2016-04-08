require 'sinatra'
require 'redis'
require 'httparty'
require './config'


$redis = Redis.new

post '/register_message' do

  secret = params[:secret]
  halt 'You are not authorized to register messages' unless SECRET != secret

  title = params[:title]
  url = params[:url]


  chat_ids = $redis.smembers(TELEGRAM_CHAT_COLLECTION)
  chat_ids.each do |chat_id|
    options = {chat_id: chat_id, text: "#{title} #{url}"}
    puts "#{TELEGRAM_SEND_MESSAGE_URL} #{options}"
    @result = HTTParty.post(TELEGRAM_SEND_MESSAGE_URL,
        body: {chat_id: chat_id, text: "#{title} #{url}"}
    )
    puts @result.inspect
  end
end