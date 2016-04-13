class CommandFactory

  attr_accessor :message

  COMMAND_SYNONYMS = {
    '/start' => 'Меню',
    '/news' => 'Новости',
    '/popular' => 'Популярное',
    '/subscribe' => 'Подписка на новости',
    '/unsubscribe' => 'Отписаться',
    '/stop' => 'Попращатсья'
  }

  def get_command(message, chat_id, bot, subscription_manager)
    @message = message
    if message_in_command_list?
      if command_is? '/start'
        return StartCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/news'
        return NewsCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/popular'
        return PopularCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/subscribe'
        return SubscribeCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/unsubscribe'
        return UnsubscribeCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/stop'
        return StopCommand.new(bot,chat_id, subscription_manager)
      else
        raise NotImplementedError('not implemented yet')
      end
    else
      raise NotImplementedError('not implemented yet')
      # @bot.api.send_message(chat_id: chat_id, text: 'Нипонятно',reply_markup: @answers)
    end
  end

  private
  def command_is?(cmd)
    BotMenu::COMMAND_SYNONYMS.invert[@message] == cmd || @message.start_with?(cmd)
  end

  def message_in_command_list?
    BotMenu::COMMAND_SYNONYMS.invert.key?(@message) || BotMenu::COMMAND_SYNONYMS.keys.include?(@message) || @message.start_with?('/start')
  end
end