*** Settings ***
Library    Selenium2Library    timeout=10
Library    BuiltIn
Library    String


*** Test Cases ***
TC_Search_002 Search with product name

    # Open browser with chrome
    Open Browser  https://www.officemate.co.th/en  chrome

    # Waiting for loading page
    Sleep    10s

    # Remove the pop-up notification that prevents Robot from using the core elements
    Execute JavaScript    document.querySelectorAll('div[class*="sp-fancy"]').forEach(function(obj) {obj.remove()})
    
    # Declare variable to find Element Search Box
    ${SearchBox}=    Get WebElement    xpath=//*[@id="app"]/div[2]/div[1]/div/div[1]/div[1]/div[1]/input

    # Set Focus To Element    ${SearchBox}
    Press Keys    ${SearchBox}    RETURN

    # Waiting for loading page
    Sleep    5s

    # Input product name keyword to Search box
    Input Text    ${SearchBox}   pencil
    
    # Waiting for autocomplete loading
    Sleep    2s

    # Press Enter to execute searching
    Press Keys   ${SearchBox}   RETURN

    # Waiting for loading page
    Sleep    5s

    # Get product name
    ${Item Text}=    Get Text    xpath=/html/body/div[1]/div/div[4]/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div/div[1]/div[3]/div[1]/h2/a

    # Convert product name to lower case
    ${Item Text Lower}=    Convert To Lower Case    "${Item Text}"

    # Assert that the result should contain input product name
    Should Contain    ${Item Text Lower}    pencil

    #Close all browsers
    Close All Browsers
