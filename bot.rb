#encoding: utf-8
require 'telegram/bot'
require 'redis'
require './config'
require 'byebug'
Dir["./lib/*.rb"].each {|file| require file }
Dir["./lib/commands/*.rb"].each {|file| require file }


start_message = %{
#  ██╗  ██╗██╗      ██████╗ ██████╗ ███████╗
#  ██║ ██╔╝██║     ██╔═══██╗██╔══██╗██╔════╝
#  █████╔╝ ██║     ██║   ██║██████╔╝███████╗
#  ██╔═██╗ ██║     ██║   ██║██╔═══╝ ╚════██║
#  ██║  ██╗███████╗╚██████╔╝██║     ███████║
#  ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝     ╚══════╝
#

→ Listening for commands
}


$redis = Redis.new(host: ENV["REDIS_PORT_6379_TCP_ADDR"], port: ENV["REDIS_PORT_6379_TCP_PORT"])
subscription_manager = SubscriptionManager.new($redis)

Telegram::Bot::Client.run(TELEGRAM_BOT_TOKEN, logger: Logger.new($stdout)) do |bot|
  puts start_message

  bot.listen do |message|

    factory = CommandFactory.new
    command = factory.get_command(message.text, message.chat.id, bot, subscription_manager)
    command.execute
  end
end