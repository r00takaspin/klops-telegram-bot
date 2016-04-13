require 'json'
class KlopsPopularNews

  KLOPS_POPULAR_NEWS_FEED = 'https://klops.ru/api/get_popular'
  NEWS_LIMIT = 5

  attr_accessor :items

  def initialize(*args)
    #TODO: implement by day, by three days, by week
  end

  def fetch!
    json = JSON.parse make_request
    json_items = json['news']
    @items = json_items[0..NEWS_LIMIT-1].map {|item| [item['title'], item['url']] }
  end

  private
  def make_request
    open(KLOPS_POPULAR_NEWS_FEED).read
  end
end