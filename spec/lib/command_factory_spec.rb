require 'fakeredis'
require 'telegram/bot'

describe CommandFactory do

  let (:some_chat_id) { 285357893759834759843579 }
  let (:bot) { Telegram::Bot::Client.new('xxxxx') }
  let (:subscription_manager) { SubscriptionManager.new(Redis.new) }
  let (:factory) { factory = CommandFactory.new }

  it 'should return help command' do
    command = factory.get_command('/start', bot, some_chat_id, subscription_manager)
    expect(command).to be_a_kind_of(StartCommand)
  end

  it 'should return news command' do
    command = factory.get_command('/news', bot, some_chat_id, subscription_manager)
    expect(command).to be_a_kind_of(NewsCommand)
  end

  it 'should return popular command' do
    command = factory.get_command('/popular', bot, some_chat_id, subscription_manager)
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

  it 'should return stop command' do
    command = factory.get_command('/stop', bot, some_chat_id, subscription_manager)
    expect(command).to be_a_kind_of(StopCommand)
  end
end