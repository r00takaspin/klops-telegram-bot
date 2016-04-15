class PopularMenu

  attr_accessor :answers

  COMMAND_SYNONYMS = {
    '/popular one_day' => 'За день',
    '/popular three_days' => 'За три дня',
    '/popular week' => 'За неделю',
    '/start' => 'Назад'
  }

  MENU = [
    [COMMAND_SYNONYMS['/popular two_days'],COMMAND_SYNONYMS['/popular four_days'], COMMAND_SYNONYMS['/popular week']],
    [COMMAND_SYNONYMS['/start']]
  ]

  def initialize
    @answers = MENU.clone
  end
end