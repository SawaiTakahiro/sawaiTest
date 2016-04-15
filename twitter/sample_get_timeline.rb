#! ruby -Ku

=begin
 2016/04/15
 twitterのAPI使って見るテスト
=end

##########################################################################################
#共通の部分
require "Twitter"

#設定ファイルの管理
require "dotenv"
#APIキーとかを読み込んで設定する
Dotenv.load

hoge = ENV["TWITTER_CONSUMER_KEY"]

client = Twitter::REST::Client.new do |config|
	config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
end

##########################################################################################
tl = client.user_timeline(ENV["MY_ACOUNT_NAME"], {count:5, page:1})

tl.each do |tweet|
	puts tweet.user.screen_name + ':' + tweet.text
end
