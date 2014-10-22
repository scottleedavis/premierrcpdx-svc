require 'net/smtp'

def send_results( results = {} )

  results[:offroad].each do |r|
    send_message('offroad',r.keys[0],r.values[0])
  end
  results[:onroad].each do |r|
    send_message('onroad',r.keys[0],r.values[0])
  end
  results[:oval].each do |r|
    send_message('oval',r.keys[0],r.values[0])
  end  
end

def send_message(mode, date,link)
message = <<MESSAGE_END
From: rctechforum-scrapper me@localhost
To: skawtus@gmail.com
Subject: #{mode} results for #{date}

#{link}

MESSAGE_END
binding.pry
  Net::SMTP.start('localhost') do |smtp|
    smtp.send_message message, 'me@localhost', 'skawtus@gmail.com'
  end
end 


