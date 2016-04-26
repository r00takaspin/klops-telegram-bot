# Manages subscription for news updates
class SubscriptionManager
  TELEGRAM_CHAT_COLLECTION = 'telegram_chats'.freeze

  attr_accessor :redis, :collection_name

  def initialize(redis)
    @redis = redis
  end

  def subscribe(chat_id)
    @redis.sadd(TELEGRAM_CHAT_COLLECTION, chat_id)
  end

  def unsubscribe(chat_id)
    @redis.srem(TELEGRAM_CHAT_COLLECTION, chat_id)
  end

  def subscribed?(chat_id)
    @redis.sismember(TELEGRAM_CHAT_COLLECTION, chat_id)
  end
end
