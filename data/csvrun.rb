require 'google_drive'
require 'csv'
require 'yt'

Yt.configuration.api_key = "AIzaSyBfglVM5_q4sTW_jpp4ZFlqbiPD_g4LeSU"   
session = GoogleDrive::Session.from_config("config.json")
# https://docs.google.com/spreadsheets/d/1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q/edit#gid=0
ws = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[0]
ws_archive = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[1]


CSV.open("data.csv", "w") do |csv|
  #Header title
  csv << ["Date","","Channel","Type", "Location","Subs Before","Subs After","Subs Today","Uploads Before","Uploads Today"]
	#Reads the spreadsheet values to csv file
	for i in 3..ws.num_rows.to_i
		csv << [ws[i,1],ws[i,10],ws[i,11],ws[i,4],ws[i,5],ws[i,6],ws[i,7],ws[i,12],ws[i,8],ws[i,13]] 
	end
	#updated the row number if the subc_after is filled out.
	# if ws[ws.num_rows.to_i,7].to_i != 0
		# to_file_row = ws.num_rows.to_i
	# end
end

open('date.txt', 'w') do |f|
	  f<< Time.now.strftime('%Y-%m-%d %H:%M:%S %Z')
end
