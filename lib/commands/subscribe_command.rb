class SubscribeCommand < BotCommand

  SUBSCRIPTION_MESSAGE = 'Вы подписались на получение уведомлений о срочных новостях. Чтобы отписаться - нажмите соответствующую кнопку в меню.'

  def execute
    @subscription_manager.subscribe(@chat_id)
    switch_subscription
    @answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @menu_answers, one_time_keyboard: true, resize_keyboard: true)
    @bot.api.send_message(chat_id: @chat_id, text: SUBSCRIPTION_MESSAGE,reply_markup: @answers)
  end
end