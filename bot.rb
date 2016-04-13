#encoding: utf-8
require 'telegram/bot'
require 'redis'
require './config'
require 'byebug'
Dir["./lib/*.rb"].each {|file| require file }


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

    command = CommandFactory.new(bot, subscription_manager, message.chat.id, message.text)

    # response = BotResponse.new(bot, subscription_manager, message)
    # bot.logger.info("→ #{message.text} from #{message.chat.first_name} #{message.chat.last_name} (##{message.chat.id})")
    # response.send!
  end
end