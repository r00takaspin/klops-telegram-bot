#encoding: utf-8
require 'telegram/bot'
require 'redis'
require './config'

Dir["./lib/*.rb"].each {|file| require file }


def send_news(bot,message)
  if NewsSource.news.any?
    NewsSource.news.each do |item|
      bot.api.send_message(chat_id: message.chat.id, text: "#{item[0]} #{item[1]}" )
    end
  end
end

def send_popular(bot,message)
  if NewsSource.popular.any?
    NewsSource.popular.each do |item|
      bot.api.send_message(chat_id: message.chat.id, text: "#{item[0]} #{item[1]}" )
    end
  end
end

welcome_message = %{
Оффициальный бот Klops приветствует тебя!
Список комманд:
\/start - начать общение с ботом
\/help - список комманд
\/news - список последних новостей
\/popular - популярные новости за сутки
\/subscribe - подписаться на важные новости (не более 3х за день)
\/unsubscribe - отписать от новостей
\/stop - закончить общение с ботом
}


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

subscription_manager = SubscriptionManager.new($redis,REDIS_TELEGRAM_CHAT_COLLECTION)

Telegram::Bot::Client.run(TELEGRAM_BOT_TOKEN, logger: Logger.new($stdout)) do |bot|
  puts start_message

  bot.listen do |message|

    bot.logger.info("→ #{message.text} from #{message.chat.first_name} #{message.chat.last_name} (##{message.chat.id})")

    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: welcome_message)
    when '/help'
      bot.api.send_message(chat_id: message.chat.id, text: welcome_message)
    when '/news'
      bot.api.send_message(chat_id: message.chat.id, text: 'Cписок последних новостей')
      send_news(bot,message)
    when '/popular'
      bot.api.send_message(chat_id: message.chat.id, text: 'Популярные новости за сутки')
      send_popular(bot,message)
    when '/subscribe'
      subscription_manager.subscribe(message.chat.id)
      bot.api.send_message(chat_id: message.chat.id, text: 'Вы подписались на новости в чате, чтобы отписаться введите комманду /unsubscribe')
    when '/unsubscribe'
      subscription_manager.unsubscribe(message.chat.id)
      bot.api.send_message(chat_id: message.chat.id, text: 'Вы успешно отписались от рассылки новостей')
    when  '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "До свидания, #{message.from.first_name}")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Не знаю такого: #{message.text}")
    end
  end
end