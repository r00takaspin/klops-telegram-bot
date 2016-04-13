class PopularCommand < BotCommand

  attr_accessor :period

  def initialize(period, *args)
    @period = period
    super *args
  end

  def execute
    @menu = PopularMenu.new
    @answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @menu.answers, one_time_keyboard: true)
    source = KlopsPopularNews.new(@period)
    source.fetch!
    if source.items.any?
      source.items.each do |item|
        @bot.api.send_message(chat_id: @chat_id, text: "#{item[0]} #{item[1]}",reply_markup: @answers)
      end
    end
  end
end