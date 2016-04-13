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
        StartCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/news'
        NewsCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/popular'
        PopularCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/subscribe'
        SubscribeCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/unsubscribe'
        UnsubscribeCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/stop'
        StopCommand.new(bot,chat_id, subscription_manager)
      else
        raise Exception.new('Very strange command')
      end
    else
      UnknownCommand.new(bot,chat_id, subscription_manager)
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