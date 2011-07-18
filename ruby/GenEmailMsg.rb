require 'net/smtp'
require 'pp'

class GenEmailMsg
		attr_reader	:mailMsg, :fileName, :to, :from, :subject, :message

		def initialize(to,from,subject,message,fileName)
			@to = to
			@from = from
			@subject = subject
			@message = String.new(message.gsub("..",".\n"))
			@fileName = fileName
			
    		begin
    		    myFile = File.new("logs/version.log","rb")
    		    version = myFile.read
    		    myFile.close
    		rescue
    		    version = "no platform information avaliable."
    		end
    		
			# Read a file and encode it into base64 format
			filecontent = File.read(@fileName)
			encodedcontent = [filecontent].pack("m")   # base64

			marker = "AUNIQUEMARKER"

			body = @message + "\nTests run on : " + version

			# Define the main headers.
			part1 =<<EOF
From: #{@from}
To: #{@to}
Subject: #{@subject}
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=#{marker}
--#{marker}
EOF

			# Define the message action
			part2 =<<EOF
Content-Type: text/plain
Content-Transfer-Encoding:8bit

#{body}
--#{marker}
EOF

			# Define the attachment section
			part3 =<<EOF
Content-Type: multipart/mixed; name=\"#{@fileName}\"
Content-Transfer-Encoding:base64
Content-Disposition: attachment; filename="#{@fileName}"

#{encodedcontent}
--#{marker}--
EOF

			@mailMsg = part1 + part2 + part3
		end
		
		def send
			begin
				  Net::SMTP.start('YR-EXCHANGE.softdev.pindar.com') do |smtp|
					 smtp.sendmail(@mailMsg, @from, [@to])
			end
			rescue Exception => e  
				  print "Exception occured: " + e  + "\n"
				  pp e.backtrace
			end		
		end
		
end

if ARGV.length == 3 then
	subject = ARGV[0]
	body = ARGV[1]
	file = ARGV[2]
	
	from = "web.client@pindar.com"
	tos = ["a.montgomery@pindar.com","j.finn@pindar.com","jon.richards@pindar.com"]
#	tos = ["a.montgomery@pindar.com"]

    tos.each { |to|
    	mailMsg = GenEmailMsg.new(to,from,subject,body,file)	
    	mailMsg.send
    }
else
	puts "Usage : GenMailMsg <Subject> <Body> <Logfile>"
end
