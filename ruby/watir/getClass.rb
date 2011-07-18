def getClass(browser,elementType,elementID)


    $log.debug "Finding class of ["+elementType+"]["+elementID+"]"
    elementClass = browser.send(elementType, :id, elementID).attribute_value("class")
    if elementClass == nil
        #If element class not found parse it from HTML
        elementHTML = browser.send(elementType, :id, elementID).html
        elementClass = elementHTML.split('"')[1]
        $log.debug "Parsed Class ="+elementClass
    end
    $log.debug "Class is ["+elementClass+"]"
    return elementClass
end