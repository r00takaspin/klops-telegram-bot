# Executes when user send undefined message
class UnknownCommand < BotCommand
  def execute
    @bot.api.send_message(chat_id: chat_id, text: 'Непонятно', reply_markup: @answers)
  end
end
