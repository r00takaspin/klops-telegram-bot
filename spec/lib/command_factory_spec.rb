# encodig: utf-8
require 'fakeredis'
require 'telegram/bot'

describe CommandFactory do
  let(:some_chat_id) { 999_999_999 }
  let(:bot) { Telegram::Bot::Client.new('xxxxx') }
  let(:subscription_manager) { SubscriptionManager.new(Redis.new) }
  let(:factory) { CommandFactory.new }
  let(:factory_options) { [bot, some_chat_id, subscription_manager] }

  describe 'menu' do
    it 'should return start command' do
      command = factory.get_command('/start', *factory_options)
      expect(command).to be_a_kind_of(StartCommand)
    end

    it 'humanized: should return start command' do
      command = factory.get_command('Информация', *factory_options)
      expect(command).to be_a_kind_of(StartCommand)
    end
  end

  describe 'news' do
    it 'should return news command' do
      command = factory.get_command('/news', *factory_options)
      expect(command).to be_a_kind_of(NewsCommand)
    end

    it 'humanize: should return news command' do
      command = factory.get_command('Новости', *factory_options)
      expect(command).to be_a_kind_of(NewsCommand)
    end
  end

  describe 'popular' do
    it 'should return popular command' do
      command = factory.get_command('/popular', *factory_options)
      expect(command).to be_a_kind_of(PopularMenuCommand)
    end

    it 'humanizer: should return popular command' do
      command = factory.get_command('Популярное', *factory_options)
      expect(command).to be_a_kind_of(PopularMenuCommand)
    end

    it 'humanize: one day' do
      command = factory.get_command('За день', *factory_options)
      expect(command).to be_a_kind_of(PopularCommand)
    end

    it 'humanize: three days' do
      command = factory.get_command('За три дня', *factory_options)
      expect(command).to be_a_kind_of(PopularCommand)
    end

    it 'humanize: week' do
      command = factory.get_command('За неделю', *factory_options)
      expect(command).to be_a_kind_of(PopularCommand)
    end
  end

  it 'should return popular command' do
    command = factory.get_command('/popular week', *factory_options)
    expect(command).to be_a_kind_of(PopularCommand)
  end

  it 'should return subscribe command' do
    command = factory.get_command('/subscribe', *factory_options)
    expect(command).to be_a_kind_of(SubscribeCommand)
  end

  it 'should return unsubscribe command' do
    command = factory.get_command('/unsubscribe', *factory_options)
    expect(command).to be_a_kind_of(UnsubscribeCommand)
  end

  describe 'stop' do
    it 'should return stop command' do
      command = factory.get_command('/stop', *factory_options)
      expect(command).to be_a_kind_of(StopCommand)
    end
  end
end
