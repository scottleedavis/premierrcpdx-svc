require 'faraday'
require 'faraday_middleware'
require 'nokogiri'

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
  resp_offroad = conn(url).get
  offroad_doc = Nokogiri::HTML(resp_offroad.body)
  offroad_doc.css('tr td div a.bigusername').each do |f|
    if f.content == 'PremierRCpdx'
      f.parent.parent.parent.parent.css('a').each do |dd|
        if dd.content.include? "pdf"
          yield dd.attributes["href"].value
        end
      end
    end
  end
end

