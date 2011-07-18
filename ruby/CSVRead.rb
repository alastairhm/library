#
#  CSVRead.rb
#  
#
#  Created by Alastair Montgomery
#  Copyright (c) 2010 Pindar. All rights reserved.
#
require 'csv'
require 'pp'

class CSVRead

    attr_reader :filename, :array, :size

    def initialize(filename)
        all = Array.new()
        @filename = filename
        file = File.open( filename )
        CSV::Reader.create( file ).each do |row|
            if row[0] != "#"
                all.push(row)
            end
        end
        @size = all.length
        @array = all
        file.close
    end
    
end

# myData = CSVRead.new("test.csv")
# pp myData.array
# pp myData.size
# pp myData.array[1]
# pp myData.array[2][0]