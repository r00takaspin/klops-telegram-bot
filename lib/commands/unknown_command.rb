class UnknownCommand < BotCommand
  def execute
    @bot.api.send_message(chat_id: chat_id, text: 'Нипонятно',reply_markup: @answers)
  end
end