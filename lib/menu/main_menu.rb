class MainMenu

  attr_accessor :answers

  COMMAND_SYNONYMS = {
    '/start' => 'Информация',
    '/news' => 'Новости',
    '/popular' => 'Популярное',
    '/subscribe' => 'Подписка на новости',
    '/unsubscribe' => 'Отписаться',
  }

  MENU = [
    [COMMAND_SYNONYMS['/news'], COMMAND_SYNONYMS['/popular']],
    [COMMAND_SYNONYMS['/unsubscribe'], COMMAND_SYNONYMS['/start']]
  ]

  def initialize
    @answers = MENU.clone
  end
end