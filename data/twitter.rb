require "twitter"

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "tJs5SZgyVWHvIxcFrpjtqoXIA"
  config.consumer_secret     = "WVBrMdNtllPYhUGdOtqzcLs60Yijrl8v7V8sCKTOFjyUDaL6F8"
  config.access_token        = "895386506810052609-aQFFWoeC1Fx8D3rilxYfVA6RDslbI92"
  config.access_token_secret = "rydrFq97JsVv1PHRCuGEufdUxfvpPEt2iOPvofP5FYdaz"
end
name = "dejloafVEVO"
handle = "@DeJLoaf"

# client.update("Today's Creator on the Rise is #{name} #{handle}")
client.update("Yesterday's Creator on the Rise is #{name} #{handle}")
