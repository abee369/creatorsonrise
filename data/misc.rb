require "google_drive"
require 'json'
require 'csv'
require 'yt'

# time = Time.new

# values = time.to_a
# puts Time.utc(*values)


# time = Time.new
# values = time.to_a
# t = Time.utc(*values)
# t_a = Time.now.strftime('%Y-%m-%d %H-%M-%S')
# numrows = CSV.readlines('creators.csv').size

# open('log.out', 'w') do |f|
#   f<< t
#   f.puts
#   f<<numrows
# end

# time = IO.readlines("log.out")[0]
# row = IO.readlines("log.out")[1]
# puts(time)
# puts(row)
# a =23
# print("<img src= \"#{a}\">")

# # "text contains \"#{search.query}\""
# number = 908090
# # p  num_string.reverse.scan(/\d{3}|.+/).join(",").reverse
# p number.to_s.reverse.scan(/\d{1,3}/).join(",").reverse


# COLUMNS = ["date","thumbnail","name_link","type", "location","sub_before","sub_after","sub_today","video_today"]

# # open new csv for writing
# CSV.open("data.csv", "wb") do |csv|
#   # iterating existing csv rows
#   csv << ["Date","","Channel","Type", "Location","Subs Before","Subs After","Subs Today","Videos Today"]
#   CSV.foreach('creators.csv', :headers=>true) do |row|
#     # select only those specified above columns
#     csv << COLUMNS.map { |col| row[col] }
#   end
# end

# session = GoogleDrive::Session.from_config("config.json")
# Yt.configuration.api_key = "AIzaSyBfglVM5_q4sTW_jpp4ZFlqbiPD_g4LeSU"   

# ws = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[0]
# ws_archive = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[1]

# # # ws[2,12] = "<a href= \"#{ws[2,11]}\">"
# # # ws.save
# # # ws.reload
# # archive_row = 6

# # ws_archive[archive_row,1] = Time.now.strftime('%Y-%m-%d')
# # ws_archive[archive_row,2] = Time.now.strftime('%H:%M:%S %Z')

# # # p ws_archive.num_cols
# # for i in 2..ws_archive.num_cols-1
# # 	channel = Yt::Channel.new id: ws_archive.rows[0][i]
# # 	p channel.subscriber_count
# # 	ws_archive[archive_row,i+1] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse  #the four increase 
# # 	ws_archive.save
# # 	ws_archive.reload
# # end

# to_file_row = 3
# CSV.open("data_2.csv", "wb") do |csv|
#   #Header title
#   csv << ["Date","","Channel","Type", "Location","Subs Before","Subs After","Subs Today","Uploads Before","Uploads Today"]
# 	#Reads the spreadsheet values to csv file
# 	for i in to_file_row..ws.num_rows.to_i
# 		csv << [ws[i,1],ws[i,10],ws[i,11],ws[i,4],ws[i,5],ws[i,6],ws[i,7],ws[i,12],ws[i,8],ws[i,13]] 
# 	end
# 	#updated the row number if the subc_after is filled out.
# 	if ws[ws.num_rows.to_i,7].to_i != 0
# 		to_file_row+=1
# 	end
# end
require 'date'
p DateTime.now.utc

p DateTime.now.in_time_zone('Central Time (US & Canada)').strftime('%Y-%m-%d %H:%M:%S %Z')

