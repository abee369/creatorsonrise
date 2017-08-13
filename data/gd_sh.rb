require "google_drive"
require 'json'
require 'csv'
require 'yt'




time = IO.readlines("log.out")[0]
row = IO.readlines("log.out")[1]
archive_row = IO.readlines("log.out")[2].to_i
puts(time)
puts(row)
puts(archive_row)
Yt.configuration.api_key = "AIzaSyBfglVM5_q4sTW_jpp4ZFlqbiPD_g4LeSU"   
session = GoogleDrive::Session.from_config("config.json")
# https://docs.google.com/spreadsheets/d/1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q/edit#gid=0
ws = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[0]
ws_archive = session.spreadsheet_by_key("1YxErXc6UpWoY3eStcZzbwLgDatfgIyHVEXKjK59Kg3Q").worksheets[1]

# puts(ws.rows.length)
# for i in row.to_i..ws.rows.length
# 	print(ws.rows[i])	
# end
x =2
if x ==1
	channel = Yt::Channel.new id: ws.rows[1][1]
	ws[2,4] = "<img src= \"#{channel.thumbnail_url}\">"
	ws[2,9] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
	ws[2,10] = channel.video_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
	ws[2,12] = "<a href= \"#{ws[2,11]}\"target=\"_blank\">#{ws[2,3]}</a>"
	ws[2,13] = 1
	ws.save
	ws.reload
	CSV.open("creators.csv", "w") do |csv|
		csv<<["date", "channel_id", "title", "thumbnail", "type", "location", "sub_before", "sub_after", "sub_today", "video_today","link","name_link","num"]
		csv<<ws.rows[1]
	end
	time = Time.new
	values = time.to_a
	t = Time.utc(*values)
	t_a = Time.now.strftime('%Y-%m-%d %H-%M-%S')
	numrows = CSV.readlines('creators.csv').size
	open('log.out', 'w') do |f|
	  f<< t
	  f.puts
	  f<<numrows
	  f.puts
	  f<<ws_archive.num_rows

	end
	#archive
	ws_archive[1,3] = ws[2,2] #the three increments
	ws_archive[2,3] = ws[2,3]
	ws_archive[3,3] = ws[2,11]
	# ws_archive[4,3] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse  #the four increase 


	ws_archive.save
	ws_archive.reload

	ws_archive[4,1] = Time.now.strftime('%Y-%m-%d')
	ws_archive[4,2] = Time.now.strftime('%H:%M:%S %Z')

	# p ws_archive.num_cols
	for i in 2..ws_archive.num_cols-1
		channel = Yt::Channel.new id: ws_archive.rows[0][i]
		p channel.subscriber_count
		ws_archive[4,i+1] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse  #the four increase 
		ws_archive.save
		ws_archive.reload
	end


else
	ws_archive[archive_row,1] = Time.now.strftime('%Y-%m-%d')
	ws_archive[archive_row,2] = Time.now.strftime('%H:%M:%S %Z')

	for i in row.to_i..ws.num_rows-1
		p i
		p "@@@@@@@@@@@@@@@@@@@@"
		channel = Yt::Channel.new id: ws.rows[i][1]
		ws[i+1,3] = channel.title
		ws[i+1,4] = "<img src= \"#{channel.thumbnail_url}\">"
		ws[i+1,9] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
		ws[i+1,10] = channel.video_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
		ws[i+1,12] = "<a href= \"#{ws[i+1,11]}\"target=\"_blank\">#{ws[i+1,3]}</a>"
		col = ws[i,13].to_i
		puts("collllll:   #{col}")
		ws[i+1,13] = col+1

		ws.save
		ws.reload
		CSV.open("creators.csv", "a") do |csv|
			csv<<ws.rows[i]
		end
	ws_archive[1,col+2] = ws[i+1,2] #the three increments
	ws_archive[2,col+2] = ws[i+1,3]
	ws_archive[3,col+2] = ws[i+1,11]
	ws_archive.save
	ws_archive.reload
	end

	time = Time.new
	values = time.to_a
	t = Time.utc(*values)
	t_a = Time.now.strftime('%Y-%m-%d %H-%M-%S')
	numrows = CSV.readlines('creators.csv').size
	open('log.out', 'w') do |f|
	  f<< t
	  f.puts
	  f<<numrows
	  f.puts
	  f<<ws_archive.num_rows+1

	end

end

ws_archive[archive_row,1] = Time.now.strftime('%Y-%m-%d')
ws_archive[archive_row,2] = Time.now.strftime('%H:%M:%S %Z')

# p ws_archive.num_cols
for i in 2..ws_archive.num_cols-1
	channel = Yt::Channel.new id: ws_archive.rows[0][i]
	p channel.subscriber_count
	ws_archive[archive_row,i+1] = channel.subscriber_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse  #the four increase 
	ws_archive.save
	ws_archive.reload
end





COLUMNS = ["date","thumbnail","name_link","type", "location","sub_before","sub_after","sub_today","video_today"]

# open new csv for writing
CSV.open("data.csv", "wb") do |csv|
  # iterating existing csv rows
  csv << ["Date","","Channel","Type", "Location","Subs Before","Subs After","Subs Today","Videos Today"]
  CSV.foreach('creators.csv', :headers=>true) do |row|
    # select only those specified above columns
    csv << COLUMNS.map { |col| row[col] }
  end
end



# Yt.configuration.api_key = "AIzaSyBfglVM5_q4sTW_jpp4ZFlqbiPD_g4LeSU"   

# channel = Yt::Channel.new id: 'UCnprfRlJB7WE6zAEaOAfVYA'
# # channel = Yt::Channel.new id: 'UCZh-rzD9Dn2l3d-tCbuE4dQ'

# puts(channel.title) #=> "Fullscreen"
# puts(channel.thumbnail_url)
# puts(channel.video_count)
# puts(channel.subscriber_count)




# p ws.rows
# p ws.rows.length
# # p ws[1, 1]  #==> "hoge"

# # # # # Changes content of cells.
# # # # # Changes are not sent to the server until you call ws.save().
# # # # ws[2, 1] = "foo"
# # # # ws[2, 2] = "bar"
# # # # ws.save

# # # # Dumps all cells.
# # # (1..ws.num_rows).each do |row|
# # #   (1..ws.num_cols).each do |col|
# # #     p ws[row, col]
# # #   end
# # # end

# # # Yet another way to do so.
# # p ws.rows[0]  #==> [["fuga", ""], ["foo", "bar]]
# # ws[2,3] = channel.title
# # ws[2,4] = channel.thumbnail_url
# # ws[2,9] = channel.subscriber_count
# # ws[2,10] = channel.video_count

# # ws.save
# # # Reloads the worksheet to get changes by other clients.
# # ws.reload


# # CSV.open("creators.csv", "w") do |csv|
# # 	csv<<["date", "channel_id", "title", "thumbnail", "type", "location", "sub_before", "sub_after", "sub_today", "video_today"]
# # 	csv<<ws.rows[1]
# # end
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



