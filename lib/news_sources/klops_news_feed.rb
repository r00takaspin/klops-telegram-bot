require 'rss'

class KlopsNewsFeed

  attr_accessor :limit, :items

  KLOPS_RSS_FEED = 'https://klops.ru/rss.rss'
  NEWS_LIMIT = 5

  def initialize(limit = false)
    @limit = limit ? limit : NEWS_LIMIT
  end

  def fetch!
    response = make_request
    feed = RSS::Parser.parse response
    @items = feed.items[0..@limit - 1].map { |item| [item.title, item.link] }
  end

  private
  def make_request
    response = HTTParty.get KLOPS_RSS_FEED
    return response.body
  end
end