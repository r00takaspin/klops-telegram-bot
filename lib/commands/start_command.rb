class StartCommand < BotCommand

  WELCOME_MESSAGE = %{
Вас приветствует официальный бот Клопс.Ru!

С моей помощью можно узнать о самых популярных или свежих новостях. Кроме того, вы можете подключить подписку и получать от меня немедленные уведомления о самых важных новостях.

Если вы устали от меня и хотите выключить - введите команду /stop.

Список комманд:
\/start - начать общение с ботом
\/news - список последних новостей
\/popular - популярные новости за сутки
\/subscribe - подписаться на важные новости (не более 3х за день)
\/unsubscribe - отписать от новостей
\/stop - закончить общение с ботом
}

  def execute
    @bot.api.send_message(chat_id: @chat_id, text: WELCOME_MESSAGE, reply_markup: @answers)
  end
end