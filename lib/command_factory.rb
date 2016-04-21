# Resolves right command by use message
class CommandFactory
  COMMAND_SYNONYMS = {
    '/start' => 'Меню',
    '/news' => 'Новости',
    '/popular' => 'Популярное',
    '/subscribe' => 'Подписка на новости',
    '/unsubscribe' => 'Отписаться',
    '/stop' => 'Попращатсья'
  }.freeze
  attr_accessor :message, :command

  def get_command(message, chat_id, bot, subscription_manager)
    @message = message

    normalize_command!

    if @command
      if StartCommand.handles? @command
        StartCommand.new(bot, chat_id, subscription_manager)
      elsif NewsCommand.handles? @command
        NewsCommand.new(bot, chat_id, subscription_manager)
      elsif PopularMenuCommand.handles? @command
        PopularMenuCommand.new(bot, chat_id, subscription_manager)
      elsif PopularCommand.handles? @command
        params = command_params
        period = params.first
        PopularCommand.new(period, bot, chat_id, subscription_manager)
      elsif SubscribeCommand.handles? @command
        SubscribeCommand.new(bot, chat_id, subscription_manager)
      elsif UnsubscribeCommand.handles? @command
        UnsubscribeCommand.new(bot, chat_id, subscription_manager)
      elsif StopCommand.handles? @command
        StopCommand.new(bot, chat_id, subscription_manager)
      else
        UnknownCommand.new(bot, chat_id, subscription_manager)
      end
    else
      UnknownCommand.new(bot, chat_id, subscription_manager)
    end
  end

  private

  def human_command?
    @message && !@message.start_with?('/') ? true : false
  end

  def command_params
    @command.split(' ').drop(1)
  end

  def normalize_command!
    if human_command?
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
