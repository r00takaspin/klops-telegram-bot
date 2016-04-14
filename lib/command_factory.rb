class CommandFactory

  attr_accessor :message, :command

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

    normalize_command!

    if @command
      if command_is?('/start') || @command.start_with?('/start')
        StartCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/news'
        NewsCommand.new(bot, chat_id, subscription_manager)
      elsif command_is?('/popular') || @command.start_with?('/popular')
        if is_subcommand_of?('/popular')
          params = get_params
          period = params.first
          PopularCommand.new(period, bot, chat_id, subscription_manager)
        else
          PopularMenuCommand.new(bot, chat_id, subscription_manager)
        end
      elsif command_is? '/subscribe'
        SubscribeCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/unsubscribe'
        UnsubscribeCommand.new(bot, chat_id, subscription_manager)
      elsif command_is? '/stop'
        StopCommand.new(bot, chat_id, subscription_manager)
      end
    else
      UnknownCommand.new(bot, chat_id, subscription_manager)
    end
  end

  private
  def is_human_command?
    !@message.start_with?('/')
  end

  def get_params
    @command.split(' ').drop(1)
  end

  def is_subcommand_of?(cmd)
    @command.start_with?(cmd) && @command != cmd
  end

  def normalize_command!
    if is_human_command?
      if MainMenu::COMMAND_SYNONYMS.values.include?(@message)
        @command = MainMenu::COMMAND_SYNONYMS.invert[@message]
      elsif PopularMenu::COMMAND_SYNONYMS.values.include?(@message)
        @command = PopularMenu::COMMAND_SYNONYMS.invert[@message]
      end
    else
      @command = @message
    end
  end

  def command_is?(cmd)
    cmd == @command
  end
end