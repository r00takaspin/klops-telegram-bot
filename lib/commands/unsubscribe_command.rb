class UnsubscribeCommand < BotCommand
  def execute
    @subscription_manager.unsubscribe(@chat_id)
    @bot.api.send_message(chat_id: @chat_id, text: 'Вы успешно отписались от рассылки новостей',reply_markup: @answers)
  end
end