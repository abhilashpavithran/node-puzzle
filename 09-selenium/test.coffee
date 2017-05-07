assert = require 'assert'
test = require 'selenium-webdriver/testing'
webdriver = require 'selenium-webdriver'
should = require("chai").should()

sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms

test.describe 'Adslot website', ->

  # Browser (or driver) instance
  browser = null

  # Init browser before we begin
  test.before -> 
    browser = new webdriver.Builder().usingServer().withCapabilities({browserName: 'chrome'}).build()
    
  # Close browser after all tests
  test.after -> browser.quit()


  test.it 'should have 8 offices on careers page', ->

    browser.get 'http://adslot.com/careers'
    
    browser.findElements(webdriver.By.css('.ui-tabs-nav h4, .ui-tabs-nav h2')).then (menuItems) ->
      assert menuItems.length, 8
      console.log menuItems.length

  test.it 'should contain a form on "contact us" page', ->
    
    browser.get 'http://www.adslot.com/contact-us'

    browser.findElement(webdriver.By.id('first_name')).isDisplayed()
    browser.findElement(webdriver.By.id('last_name')).isDisplayed()
    browser.findElement(webdriver.By.id('company')).isDisplayed()
    browser.findElement(webdriver.By.id('email')).isDisplayed()
    browser.findElement(webdriver.By.id('website')).isDisplayed()
    browser.findElement(webdriver.By.id('message')).isDisplayed()
    browser.findElement(webdriver.By.css('select[title=Country]')).isDisplayed()
    browser.findElement(webdriver.By.css('button[type=submit]')).isDisplayed()
    browser.findElement(webdriver.By.css('a.supprt')).isDisplayed()



  test.it 'Adslot google search should take to companys link', ->
  
    browser.get 'https://www.google.com.au/'
    browser.wait () ->
      browser.getTitle().then (title)->
        title.should.have.string "Google"

    googleSearch = browser.findElement(webdriver.By.id('lst-ib'))
    googleSearch.sendKeys('Adslot')
    browser.findElement(webdriver.By.css('button[type=submit]')).click()
    
    browser.wait(webdriver.until.elementsLocated(webdriver.By.css('div.rc>h3>a')), 10000, 'unable to find element')
    .then (resultLinks) ->
        resultLinks[0].click()
        
    browser.wait () ->
      browser.getTitle().then (title)->
        title.should.have.string 'Adslot'



   test.it 'Adslot Publisher Login navigates to Login page', ->
   
    browser.get 'https://www.adslot.com/'
        
    browser.wait () ->
         browser.getTitle().then (title)->
              title.should.have.string 'Adslot'
    
    browser.findElement(webdriver.By.linkText('Login')).click()
    browser.findElement(webdriver.By.xpath('//ul[@class="sub-menu"]/li/a[text()="Publisher"]')).click()
    browser.wait () ->
         browser.getCurrentUrl().then (url)->
              url.should.have.string 'https://publisher.adslot.com/login'
           

