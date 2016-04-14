class NewsCommand < BotCommand
  def execute
    source = KlopsNewsFeed.new
    source.fetch!
    if source.items.any?
      @bot.api.send_message(chat_id: @chat_id, text: 'Cписок последних новостей: ',reply_markup: @answers)
      source.items.each do |item|
        @bot.api.send_message(chat_id: @chat_id, text: "#{item[0]} #{item[1]}" )
      end
    end
  end
end