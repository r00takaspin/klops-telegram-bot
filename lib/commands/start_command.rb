class StartCommand < BotCommand

  WELCOME_MESSAGE = %{
Официальный бот Klops приветствует тебя!
Список комманд:
\/start - начать общение с ботом
\/news - список последних новостей
\/popular - популярные новости за сутки
\/subscribe - подписаться на важные новости (не более 3х за день)
\/unsubscribe - отписать от новостей
\/stop - закончить общение с ботом
}

  def execute
    @subscription_manager.subscribe(chat_id)
    @bot.api.send_message(chat_id: chat_id, text: WELCOME_MESSAGE)
    @bot.api.send_message(chat_id: chat_id, text: 'Я вас подписал рассылку новостей, не более трех в день, честное робо-слово',reply_markup: @answers)
  end
end