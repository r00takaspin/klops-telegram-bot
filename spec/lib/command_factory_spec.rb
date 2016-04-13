#encodig: utf-8
require 'fakeredis'
require 'telegram/bot'

describe CommandFactory do

  let (:some_chat_id) { 285357893759834759843579 }
  let (:bot) { Telegram::Bot::Client.new('xxxxx') }
  let (:subscription_manager) { SubscriptionManager.new(Redis.new) }
  let (:factory) { factory = CommandFactory.new }

  describe 'menu' do
    it 'should return start command' do
      command = factory.get_command('/start', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(StartCommand)
    end

    it 'humanized: should return start command' do
      command = factory.get_command('Меню', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(StartCommand)
    end
  end

  describe 'news' do
    it 'should return news command' do
      command = factory.get_command('/news', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(NewsCommand)
    end

    it 'humanize: should return news command' do
      command = factory.get_command('Новости', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(NewsCommand)
    end
  end

  describe 'popular' do
    it 'should return popular command' do
      command = factory.get_command('/popular', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(PopularMenuCommand)
    end

    it 'humanizer: should return popular command' do
      command = factory.get_command('Популярное', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(PopularMenuCommand)
    end

    it 'humanize: one day' do
      command = factory.get_command('За день', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(PopularCommand)
    end

    it 'humanize: three days' do
      command = factory.get_command('За три дня', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(PopularCommand)
    end

    it 'humanize: wek' do
      command = factory.get_command('За неделю', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(PopularCommand)
    end
  end

  it 'should return popular command' do
    command = factory.get_command('/popular week', bot, some_chat_id, subscription_manager)
    expect(command).to be_a_kind_of(PopularCommand)
  end

  it 'should return subscribe command' do
    command = factory.get_command('/subscribe', bot, some_chat_id, subscription_manager)
    expect(command).to be_a_kind_of(SubscribeCommand)
  end

  it 'should return unsubscribe command' do
    command = factory.get_command('/unsubscribe', bot, some_chat_id, subscription_manager)
    expect(command).to be_a_kind_of(UnsubscribeCommand)
  end

  describe 'stop' do
    it 'humanize: should return stop command' do
      command = factory.get_command('Попращаться', bot, some_chat_id, subscription_manager)
      expect(command).to be_a_kind_of(StopCommand)
    end
  end


end