class PopularCommand < BotCommand
  def execute
    source = KlopsPopularNews.new
    source.fetch!
    if source.items.any?
      source.items.each do |item|
        @bot.api.send_message(chat_id: @chat_id, text: 'Популярные новости за сутки',reply_markup: @answers)
        @bot.api.send_message(chat_id: @chat_id, text: "#{item[0]} #{item[1]}" )
      end
    end
  end
end