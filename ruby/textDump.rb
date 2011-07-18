=begin

  textDump.rb
  
  Write the contents of string to file in the logs directory.
  
  Created by Alastair Montgomery on 14/6/2011.
  Copyright (c) 2011 Pindar. All rights reserved.


=end

require "pp"

def textDump(filename,myString,timed=true,extension=".txt")
    begin
        time1 = Time.new
        if timed then
            myFile = filename + "_" + time1.hour.to_s + "_" + time1.min.to_s + "_" + time1.sec.to_s + extension
        else
            myFile = filename + extension
        end
        outFile = File.new(myFile,"w")
        outFile.puts myString
        outFile.close
    rescue Exception => e
        puts "Exception occured: " + e
        pp e.backtrace
    end
end

#textDump("textDumpTest","This is a test")
#textDump("textDumpTest","This is a test",false)
