# require 'google/api_client'
require 'json'
require 'csv'
require 'yt'

Yt.configuration.api_key = "AIzaSyBfglVM5_q4sTW_jpp4ZFlqbiPD_g4LeSU"   

channel = Yt::Channel.new id: 'UCnprfRlJB7WE6zAEaOAfVYA'
# channel = Yt::Channel.new id: 'UCZh-rzD9Dn2l3d-tCbuE4dQ'

puts(channel.title) #=> "Fullscreen"
puts(channel.thumbnail_url)
puts(channel.video_count)
puts(channel.subscriber_count)

