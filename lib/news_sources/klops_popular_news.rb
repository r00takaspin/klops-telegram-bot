require 'json'
class KlopsPopularNews

  KLOPS_POPULAR_NEWS_FEED = 'https://klops.ru/api/get_popular'
  NEWS_LIMIT = 5

  attr_accessor :items, :period

  def initialize(period=:two_days)
    @period = period
  end

  def fetch!
    json = JSON.parse make_request
    json_items = json['news']
    @items = json_items[0..NEWS_LIMIT - 1].map {|item| [item['title'], item['url']] }.reverse
  end

  private
  def url
    "#{KLOPS_POPULAR_NEWS_FEED}?period=#{@period}"
  end

  def make_request
    open(url).read
  end
end