class StopCommand < BotCommand
  def execute
    kb = Telegram::Bot::Types::ReplyKeyboardHide.new(hide_keyboard: true)
    @subscription_manager.unsubscribe(@chat_id)
    @bot.api.send_message(chat_id: @chat_id, text: "До свидания", reply_markup: kb)
  end

  def self.handles?(command)
    '/stop' == command
  end
end