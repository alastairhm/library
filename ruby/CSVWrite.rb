#
#  CSVWrite.rb
#  
#
#  Created by Alastair Montgomery
#  Copyright (c) 2010 Pindar. All rights reserved.
#
require 'csv'
require 'pp'

class CSVWrite
    #Writes the passed 2 dimensional array to a CSV file

    attr_reader :filename, :array

    def initialize(filename,src)
        @filename = filename
	@array = src
	buf = ''
	src.each do |row|
		parsed_cells = CSV.generate_row(row,row.length,buf)
		#puts "Created #{ parsed_cells } cells."
	end
	#pp buf
	file = File.open(filename,'w')
	file.puts buf
	file.close
    end
end

#row1 = ['a1','a2']
#row2 = ['b1','b2']
#myArray = [row1,row2]
#pp myArray
#myWrite = CSVWrite.new('write_test.csv',myArray)

