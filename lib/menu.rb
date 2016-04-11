class Menu

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
    [COMMAND_SYNONYMS['/subscribe'], COMMAND_SYNONYMS['/unsubscribe']],
    [COMMAND_SYNONYMS['/stop']]
  ]

  def initialize(subscription_manager, chat_id)
    @subscription_manager = subscription_manager
    @chat_id = chat_id
    @answers = MENU.clone
    set_menu_subscription
  end

  def switch_subscription
    set_menu_subscription
  end

  private
  def set_menu_subscription
    if subscription_manager.subscribed?(@chat_id)
      @answers[1] = [COMMAND_SYNONYMS['/unsubscribe']]
    else
      @answers[1] = [COMMAND_SYNONYMS['/subscribe']]
    end
  end
end