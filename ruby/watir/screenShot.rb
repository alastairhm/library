#
#  screenShot.rb
#  
#
#  Created by Alastair Montgomery
#  Copyright (c) 2011 Pindar. All rights reserved.
#

require "rubygems"

def screenShot(browser,filename)
    time1 = Time.new
    browser.driver.save_screenshot("logs/"+filename + "_" + time1.hour.to_s + "_" + time1.min.to_s + "_" + time1.sec.to_s + ".png")
end
