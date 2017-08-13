require "google_drive"
require 'json'
require 'csv'
require 'yt'
session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[0]
ws_archive = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[1]
p ws_archive.rows

ws_archive[1,3] = ws[2,2] #the three increments
ws_archive[2,3] = ws[2,3]
ws_archive[3,3] = ws[2,11]
ws_archive[4,3] = "sub"  #the four increase 
ws_archive[4,1] = Time.now.strftime('%Y-%m-%d')
ws_archive[4,2] = Time.now.strftime('%H:%M:%S %Z')

ws_archive.save
ws_archive.reload