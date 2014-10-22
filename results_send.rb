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
From: topg34rr3sults@gmail.com
To: skawtus@gmail.com
Subject: #{mode} results for #{date}

#{link}
MESSAGE_END

  smtp = Net::SMTP.new('smtp.google.com', 587)
  smtp.enable_starttls
  smtp.start('premierrcpdx.com','topg34rr3sults@gmail.com','password',:login) do |s|
    s.send_message(message, 'topg34rr3sults@gmail.com', 'skawtus@gmail.com')
  end

end 


# send_message('offroad','12-12-2012','http://example.com')
