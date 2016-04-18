class PopularCommand < BotCommand

  attr_accessor :period

  def initialize(period, *args)
    @period = period
    super *args
  end

  def execute
    @menu = PopularMenu.new
    @answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @menu.answers, one_time_keyboard: true, resize_keyboard: true)
    source = KlopsPopularNews.new(@period)
    source.fetch!
    @bot.api.send_message(chat_id: @chat_id, text: desc_msg)
    if source.items.any?
      source.items.each do |item|
        @bot.api.send_message(chat_id: @chat_id, text: "#{item[0]} #{item[1]}",reply_markup: @answers)
      end
    end
  end

  def self.handles? (command)
    command.start_with?('/popular') && command != '/popular'
  end

  private
  def desc_msg
    case @period.to_sym
      when :one_day
        'Самые популярные новости за день'
      when :three_days
        'Самые популярные новости за три дня'
      when :week
        'Самые популярные новости за неделю'
      else
        'Самые популярные новости'
    end
  end
end