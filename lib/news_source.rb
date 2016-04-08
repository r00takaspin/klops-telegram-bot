require 'rss'
require 'json'
require 'open-uri'

class NewsSource

	KLOPS_RSS_FEED = 'https://klops.ru/rss.rss'

  KLOPS_POPULAR_NEWS_FEED = 'https://klops.ru/api/get_popular'

	NEWS_LIMIT = 5

	def self.news
    result = []
		rss = RSS::Parser.parse(KLOPS_RSS_FEED, false)
		rss.items.each_with_index do |item,idx|
			 break if idx > NEWS_LIMIT		
       result << [item.title, item.link]
		end
		result
	end

	def self.popular
    result = []
    json = JSON.load(open(KLOPS_POPULAR_NEWS_FEED))
    items = json['news']
    items.each_with_index do |item,idx|
      break if idx > NEWS_LIMIT
      result << [item['title'], item['url']]
    end
    result
	end
end