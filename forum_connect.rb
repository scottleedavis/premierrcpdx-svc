require 'faraday'
require 'faraday_middleware'
require 'nokogiri'
# require 'pry'

def conn(url)
  opts = {
    url: url
  }
  Faraday.new(opts) do |f|
    f.use FaradayMiddleware::FollowRedirects,
          limit: 22
    f.adapter  Faraday.default_adapter
  end
end

def get_results(url)
  resp = conn(url).get
  doc = Nokogiri::HTML(resp.body)
  doc.css('tr td div a.bigusername').each do |f|
    if f.content == 'PremierRCpdx'
      begin
        post_date = f.parent.parent.parent.parent.children[1].children[1].children[4].
        post_date.strip!
        post_date.split(',')[0]
      rescue
        post_date = [Date.today.month, Date.today.day, Date.today.year].join('-') #fallback to today's date
      end
      f.parent.parent.parent.parent.css('a').each do |dd|
        if dd.content.include? "pdf"
          yield post_date => dd.attributes["href"].value
        end
      end
    end
  end
end

