#!/usr/bin/ruby

require "net/http"
require "logger"
require "pp"

begin
        Dir.chdir("wca")
        time1 = Time.new
        filename = "updated" + "_" + time1.hour.to_s + "_" + time1.min.to_s + "_" + time1.sec.to_s + ".log"
		log = Logger.new(filename) 
		log.debug "===Checking For New Build"
		source = Net::HTTP.get('yr-qa-svr2', '/Wave/index.html')
		myFile = File.new("data/old.html","rb")
		old = myFile.read
		myFile.close

		if old != source then
			log.debug "   Server Version Changed, running tests"
			status = system("runWatir","webdriver.rb")
			if status then
				log.debug "   Command run correctly"
				myFile = File.new("data/old.html","w")
				myFile.puts source
				myFile.close
			else
				log.debug "   Failed to run command"
				log.debug "   Error number " + $?.to_s
			end
		else
			log.debug "   No Updates to Server Version"
		end
rescue Exception => e  
	  print "Exception occured: " + e  + "\n"
	  print e.backtrace
end	
