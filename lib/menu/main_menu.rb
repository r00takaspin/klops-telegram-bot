class MainMenu

  attr_accessor :answers

  COMMAND_SYNONYMS = {
    '/start' => 'Меню',
    '/news' => 'Новости',
    '/popular' => 'Популярное',
    '/subscribe' => 'Подписка на новости',
    '/unsubscribe' => 'Отписаться',
    '/stop' => 'Попращаться'
  }

  MENU = [
    [COMMAND_SYNONYMS['/start'],COMMAND_SYNONYMS['/news'], COMMAND_SYNONYMS['/popular']],
    [COMMAND_SYNONYMS['/stop']]
  ]

  def initialize
    @answers = MENU.clone
  end
end