#encoding: utf-8
require 'telegram/bot'
require 'redis'
require './config'
require 'byebug'

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

def command_is?(cmd)
  Menu::COMMAND_SYNONYMS.invert[message.text]==cmd || message.text.start_with?(cmd)
end

welcome_message = %{
Оффициальный бот Klops приветствует тебя!
Список комманд:
\/start - начать общение с ботом
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

    menu = Menu.new(subscription_manager, message.chat.id)

    answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: menu.answers, one_time_keyboard: true)

    if Menu::COMMAND_SYNONYMS.invert.key?(message.text) || Menu::COMMAND_SYNONYMS.keys.include?(message.text) || message.text.start_with?('/start')
      if command_is? '/start'
        subscription_manager.subscribe(message.chat.id)
        menu.switch_subscription
        answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: menu.answers, one_time_keyboard: true)
        bot.api.send_message(chat_id: message.chat.id, text: welcome_message)
        bot.api.send_message(chat_id: message.chat.id, text: 'Я вас подписал рассылку новостей, не более трех в день, честное робо-слово',reply_markup: answers)
      elsif command_is? '/news'
        bot.api.send_message(chat_id: message.chat.id, text: 'Cписок последних новостей: ',reply_markup: answers)
        send_news(bot, message)
      elsif command_is? '/popular'
        bot.api.send_message(chat_id: message.chat.id, text: 'Популярные новости за сутки',reply_markup: answers)
        send_popular(bot, message)
      elsif command_is? '/subscribe'
        subscription_manager.subscribe(message.chat.id)
        menu.switch_subscription
        answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: menu.answers, one_time_keyboard: true)
        bot.api.send_message(chat_id: message.chat.id, text: 'Вы подписались на новости в чате, чтобы отписаться введите комманду /unsubscribe',reply_markup: answers)
      elsif command_is? '/unsubscribe'
        subscription_manager.unsubscribe(message.chat.id)
        menu.switch_subscription
        answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: menu.answers, one_time_keyboard: true)
        bot.api.send_message(chat_id: message.chat.id, text: 'Вы успешно отписались от рассылки новостей',reply_markup: answers)
      elsif command_is? '/stop'
        kb = Telegram::Bot::Types::ReplyKeyboardHide.new(hide_keyboard: true)
        subscription_manager.unsubscribe(message.chat.id)
        bot.api.send_message(chat_id: message.chat.id, text: "До свидания, #{message.from.first_name}", reply_markup: kb)
      else
        bot.api.send_message(chat_id: message.chat.id, text: 'Нипонятно',reply_markup: answers)
      end

    end
  end
end