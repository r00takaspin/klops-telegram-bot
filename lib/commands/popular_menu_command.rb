class PopularMenuCommand < BotCommand
  def execute
    @menu = PopularMenu.new
    @answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @menu.answers, one_time_keyboard: true)
    @bot.api.send_message(chat_id: @chat_id, text: 'За какой период?', reply_markup: @answers)
  end
end