class BotMenu

  attr_accessor :subscription_manager,:chat_id, :answers

  COMMAND_SYNONYMS = {
    '/start' => 'Меню',
    '/news' => 'Новости',
    '/popular' => 'Популярное',
    '/subscribe' => 'Подписка на новости',
    '/unsubscribe' => 'Отписаться',
    '/stop' => 'Попращатсья'
  }

  MENU = [
    [COMMAND_SYNONYMS['/start'],COMMAND_SYNONYMS['/news'], COMMAND_SYNONYMS['/popular']],
    [COMMAND_SYNONYMS['/stop']]
  ]

  def initialize(subscription_manager, chat_id)
    @subscription_manager = subscription_manager
    @chat_id = chat_id
    @answers = MENU.clone
  end
end