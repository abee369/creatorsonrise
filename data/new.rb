require 'google_drive'
require 'csv'
require 'yt'

Yt.configuration.api_key = "AIzaSyBfglVM5_q4sTW_jpp4ZFlqbiPD_g4LeSU"   
session = GoogleDrive::Session.from_config("config.json")
# https://docs.google.com/spreadsheets/d/1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q/edit#gid=0
ws = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[0]
ws_archive = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[1]


# client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = "tJs5SZgyVWHvIxcFrpjtqoXIA"
#   config.consumer_secret     = "WVBrMdNtllPYhUGdOtqzcLs60Yijrl8v7V8sCKTOFjyUDaL6F8"
#   config.access_token        = "895386506810052609-aQFFWoeC1Fx8D3rilxYfVA6RDslbI92"
#   config.access_token_secret = "rydrFq97JsVv1PHRCuGEufdUxfvpPEt2iOPvofP5FYdaz"
# end


time = IO.readlines("log.out")[0]
archive_row = IO.readlines("log.out")[1].to_i
to_file_row = IO.readlines("log.out")[2].to_i
# puts(time)
# puts(row)
# puts(archive_row)

puts(ws.num_rows)
ws_archive[archive_row,1] = Time.now.strftime('%Y-%m-%d')
ws_archive[archive_row,2] = Time.now.strftime('%H:%M:%S %Z')

for i in 3..ws.num_rows.to_i
	if ws[i,15] == 'done'
		channel = Yt::Channel.new id: ws[i,2]
		ws[i,12] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
		ws[i,13] = channel.video_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
		ws_archive[archive_row,i] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse  #
	else

		channel = Yt::Channel.new id: ws[i,2]
		ws[i,9] = channel.title
		ws[i,10] = "<img src= \"#{channel.thumbnail_url}\">"
		ws[i,11] = "<a href= \"#{ws[i,3]}\"target=\"_blank\">#{ws[i,9]}</a>"
		ws[i,12] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
		ws[i,13] = channel.video_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
		ws[i,14] = ws[i-1,14].to_i+1

		col = ws[i,14].to_i+2
		ws_archive[1,col] = ws[i,2] #the three increments
		ws_archive[2,col] = ws[i,9]
		ws_archive[3,col] = ws[i,3]
		ws_archive[archive_row,i] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse  #

		# client.update("Today's Creator on the Rise is #{ws[i,9]} #{ws[i,16]}")
		ws[i,15] = 'done'
	end
end

time = Time.new
values = time.to_a
t = Time.utc(*values)

# for i in 3..ws_archive.num_cols.to_i
# 	channel = Yt::Channel.new id: ws_archive[1,i]
# 	ws_archive[archive_row,i] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse  #
# end


ws.save
ws.reload
ws_archive.save
ws_archive.reload


CSV.open("data.csv", "ab") do |csv|
  #Header title
  # csv << ["Date","","Channel","Type", "Location","Subs Before","Subs After","Subs Today","Uploads Before","Uploads Today"]
	#Reads the spreadsheet values to csv file
	for i in to_file_row..ws.num_rows.to_i
		csv << [ws[i,1],ws[i,10],ws[i,11],ws[i,4],ws[i,5],ws[i,6],ws[i,7],ws[i,12],ws[i,8],ws[i,13]] 
	end
	#updated the row number if the subc_after is filled out.
	if ws[ws.num_rows.to_i,7].to_i != 0
		to_file_row = ws.num_rows.to_i
	end
end


open('log.out', 'w') do |f|
	  f<< t
	  f.puts
	  f<<ws_archive.num_rows+1
	  f.puts
	  f<<to_file_row
end

open('date.txt', 'w') do |f|
	  f<< Time.now.strftime('%Y-%m-%d %H:%M:%S %Z')
end