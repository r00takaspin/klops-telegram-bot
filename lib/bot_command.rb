class BotCommand

  attr_reader :menu, :answers, :chat_id, :answers

  def initialize(bot, chat_id, subscription_manager)
    @bot = bot
    @chat_id = chat_id
    @subscription_manager = subscription_manager
    @menu = MainMenu.new
    switch_subscription
    @answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @menu_answers, one_time_keyboard: true, resize_keyboard: true)
  end

  def execute
    raise StandardError('not implemented')
  end

  def switch_subscription
    set_menu_subscription
  end

  private
  def set_menu_subscription
    @menu_answers = @menu.answers
    if @subscription_manager.subscribed?(@chat_id)
      @menu_answers[1] = [MainMenu::COMMAND_SYNONYMS['/unsubscribe'], MainMenu::COMMAND_SYNONYMS['/start']]
    else
      @menu_answers[1] = [MainMenu::COMMAND_SYNONYMS['/subscribe'], MainMenu::COMMAND_SYNONYMS['/start']]
    end
  end
end