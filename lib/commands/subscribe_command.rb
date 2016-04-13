class SubscribeCommand < BotCommand
  def execute
    @subscription_manager.subscribe(@chat_id)
    @bot.api.send_message(chat_id: @chat_id, text: 'Вы подписались на новости в чате, чтобы отписаться введите комманду /unsubscribe',reply_markup: @answers)
  end
end