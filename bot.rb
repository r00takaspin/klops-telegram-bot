require 'telegram/bot'
require 'telegram/bot/botan'
require 'redis'
require './config'
Dir["./lib/**/*.rb"].each {|file| require file }


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


$redis = Redis.new(host: ENV['REDIS_PORT_6379_TCP_ADDR'], port: ENV['REDIS_PORT_6379_TCP_PORT'])
subscription_manager = SubscriptionManager.new($redis)

Telegram::Bot::Client.run(TELEGRAM_BOT_TOKEN, logger: Logger.new($stdout)) do |bot|
  puts start_message

  bot.enable_botan!(ENV['BOTAN_TOKEN'])

  bot.listen do |message|

    # begin
      factory = CommandFactory.new
      command = factory.get_command(message.text, message.chat.id, bot, subscription_manager)
      command.execute
      bot.track(command.class.name, message.from.id, type_of_chat: message.chat.class.name)
    # rescue Telegram::Bot::Exceptions::ResponseError
    #   bot.logger.info('Bot has been baned')
    # end
  end
end