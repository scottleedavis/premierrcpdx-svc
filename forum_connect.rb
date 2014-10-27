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
        post_date = f.parent.parent.parent.parent.children[1].children[1].children[4].content
        post_date.strip!
        post_date = post_date.split(',')[0]
        if post_date == 'Yesterday'
          post_date = Date.today.prev_day.strftime("%m-%d-%Y")
        end
      rescue
        post_date = Date.today.strftime("%m-%d-%Y")
      end
      f.parent.parent.parent.parent.css('a').each do |dd|
        if dd.content.include? "pdf"
          yield post_date => dd.attributes["href"].value
        end
      end
    end
  end
end

