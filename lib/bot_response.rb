class BotResponse

  WELCOME_MESSAGE = %{
Официальный бот Klops приветствует тебя!
Список комманд:
\/start - начать общение с ботом
\/news - список последних новостей
\/popular - популярные новости за сутки
\/subscribe - подписаться на важные новости (не более 3х за день)
\/unsubscribe - отписать от новостей
\/stop - закончить общение с ботом
}

  attr_accessor :bot, :subscription_manager, :menu, :answers

  def initialize(bot, subscription_manager,message)
    @bot = bot
    @message = message
    @subscription_manager = subscription_manager
    @menu = BotMenu.new(subscription_manager, chat_id)
    @answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @menu.answers, one_time_keyboard: true)
  end

  def send!
    if message_in_command_list?
      if command_is? '/start'
        send_welcome_message
      elsif command_is? '/news'
        send_news
      elsif command_is? '/popular'
        send_popular
      elsif command_is? '/subscribe'
        subscribe
      elsif command_is? '/unsubscribe'
        unsubscribe
      elsif command_is? '/stop'
        byebye
      end
    else
      @bot.api.send_message(chat_id: chat_id, text: 'Нипонятно',reply_markup: @answers)
    end

  end

  private

  def message_in_command_list?
    BotMenu::COMMAND_SYNONYMS.invert.key?(@message.text) || BotMenu::COMMAND_SYNONYMS.keys.include?(@message.text) || @message.text.start_with?('/start')
  end

  def command_is?(cmd)
    BotMenu::COMMAND_SYNONYMS.invert[@message.text]==cmd || @message.text.start_with?(cmd)
  end

  def chat_id
    @message.chat.id
  end

  def send_news
    if NewsSource.news.any?
      NewsSource.news.each do |item|
        @bot.api.send_message(chat_id: chat_id, text: 'Cписок последних новостей: ',reply_markup: answers)
        @bot.api.send_message(chat_id: chat_id, text: "#{item[0]} #{item[1]}" )
      end
    end
  end

  def send_popular
    if NewsSource.popular.any?
      NewsSource.popular.each do |item|
        @bot.api.send_message(chat_id: chat_id, text: 'Популярные новости за сутки',reply_markup: answers)
        @bot.api.send_message(chat_id: chat_id, text: "#{item[0]} #{item[1]}" )
      end
    end
  end

  def send_welcome_message
    @subscription_manager.subscribe(chat_id)
    @bot.api.send_message(chat_id: chat_id, text: WELCOME_MESSAGE)
    @bot.api.send_message(chat_id: chat_id, text: 'Я вас подписал рассылку новостей, не более трех в день, честное робо-слово',reply_markup: @answers)
  end

  def subscribe
    @subscription_manager.subscribe(chat_id)
    @bot.api.send_message(chat_id: chat_id, text: 'Вы подписались на новости в чате, чтобы отписаться введите комманду /unsubscribe',reply_markup: @answers)
  end

  def unsubscribe
    @subscription_manager.unsubscribe(chat_id)
    @bot.api.send_message(chat_id: chat_id, text: 'Вы успешно отписались от рассылки новостей',reply_markup: answers)
  end

  def byebye
    kb = Telegram::Bot::Types::ReplyKeyboardHide.new(hide_keyboard: true)
    @subscription_manager.unsubscribe(chat_id)
    @bot.api.send_message(chat_id: chat_id, text: "До свидания, #{@message.from.first_name}", reply_markup: kb)
  end

end