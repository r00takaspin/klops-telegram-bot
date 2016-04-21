# Unsubscribe user from news notifications
class UnsubscribeCommand < BotCommand
  def execute
    @subscription_manager.unsubscribe(@chat_id)
    switch_subscription
    @answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(
      keyboard: @menu_answers, one_time_keyboard: true, resize_keyboard: true
    )
    msg = 'Вы отписаны от получения уведомлений о новостях.'
    @bot.api.send_message(chat_id: @chat_id, text: msg, reply_markup: @answers)
  end

  def self.handles?(command)
    '/unsubscribe' == command
  end
end
