class SubscribeCommand < BotCommand
  def execute
    @subscription_manager.subscribe(@chat_id)
    switch_subscription
    @answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @menu_answers, one_time_keyboard: true)
    @bot.api.send_message(chat_id: @chat_id, text: 'Вы подписались на новости в чате, чтобы отписаться введите комманду /unsubscribe',reply_markup: @answers)
  end
end