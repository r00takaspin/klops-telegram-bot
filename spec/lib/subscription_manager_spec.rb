require 'fakeredis'

describe SubscriptionManager do
  subject { SubscriptionManager.new(Redis.new)}

  let (:some_chat_id) { 'some_chat_id' }

  context 'subscribed?' do
    it 'chat_id is not in database' do
      expect(subject.subscribed?('asdasdas')).to be_falsey
    end

    it 'chat_id in database' do
      subject.subscribe(:some_chat_id)
      expect(subject.subscribed?(:some_chat_id)).to eq(true)
    end
  end
end