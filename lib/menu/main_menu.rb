# Main menu class
class MainMenu
  COMMAND_SYNONYMS = {
    '/start' => 'Информация',
    '/news' => 'Новости',
    '/popular' => 'Популярное',
    '/subscribe' => 'Подписаться',
    '/unsubscribe' => 'Отписаться'
  }.freeze

  MENU = [
    [
      COMMAND_SYNONYMS['/news'],
      COMMAND_SYNONYMS['/popular']],
    [
      COMMAND_SYNONYMS['/unsubscribe'],
      COMMAND_SYNONYMS['/start']
    ]
  ]

  attr_accessor :answers

  def initialize
    @answers = MENU.clone
  end
end
