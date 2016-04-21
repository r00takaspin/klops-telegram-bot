# Submenu for popular news
class PopularMenu
  COMMAND_SYNONYMS = {
    '/popular one_day' => 'За день',
    '/popular three_days' => 'За три дня',
    '/popular week' => 'За неделю',
    '/start' => 'Назад'
  }.freeze

  MENU = [
    [
      COMMAND_SYNONYMS['/popular one_day'],
      COMMAND_SYNONYMS['/popular three_days'],
      COMMAND_SYNONYMS['/popular week']
    ],
    [
      COMMAND_SYNONYMS['/start']
    ]
  ].freeze

  attr_accessor :answers

  def initialize
    @answers = MENU.clone
  end
end
