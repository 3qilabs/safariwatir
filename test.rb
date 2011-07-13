require 'rubygems'
$:.unshift("lib")
require 'safariwatir'
@browser= Watir::Safari.new
@browser.goto("http://www.apple.com/startpage/")
@browser.link(:text, /Mac Basics/).click
