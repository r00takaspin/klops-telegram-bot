class PopularMenu

  attr_accessor :answers

  COMMAND_SYNONYMS = {
    '/popular two_days' => 'За день',
    '/popular four_days' => 'За три дня',
    '/popular week' => 'За неделю',
    '/start' => 'Меню' #TODO: FIX THIS
  }

  MENU = [
    [COMMAND_SYNONYMS['/popular two_days'],COMMAND_SYNONYMS['/popular four_days'], COMMAND_SYNONYMS['/popular week']],
    [COMMAND_SYNONYMS['/start']]
  ]

  def initialize
    @answers = MENU.clone
  end
end