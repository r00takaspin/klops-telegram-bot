class SubscriptionManager

  TELEGRAM_CHAT_COLLECTION = 'telegram_chats'

  attr_accessor :redis, :collection_name

  def initialize(collection_name)
    @redis = Redis.new
    @collection_name = collection_name
  end

  def subscribe(chat_id)
    @redis.sadd(@collection_name,chat_id)
  end

  def unsubscribe(chat_id)
    @redis.srem(@collection_name,chat_id)
  end
end