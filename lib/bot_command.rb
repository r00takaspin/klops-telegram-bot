class BotCommand

  attr_reader :menu, :answers, :chat_id

  def initialize(bot, chat_id, subscription_manager)
    @bot = bot
    @chat_id = chat_id
    @menu = BotMenu.new(subscription_manager, chat_id)
    @answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @menu.answers, one_time_keyboard: true)
  end

  def execute
    raise StandardError('not implemented')
  end

  def name
    self.class
  end
end