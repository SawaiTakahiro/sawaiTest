#! ruby -Ku

=begin
 2016/04/15
 twitterのAPI使って見るテスト
=end

##########################################################################################
#共通の部分
require "Twitter"
require "./library.rb"

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

#指定したページのタイムラインを取得する
def get_timeline(client, max_count, page_num)
	return client.user_timeline(ENV["MY_ACOUNT_NAME"], {count:max_count, page:page_num})
end


#渡されたタイムラインを配列で取得する
def get_tweet(timeline)
	data = Array.new
	timeline.map do |tweet|
		data << parse_tweet_data(tweet.attrs)
	end
	
	return data
end

#つぶやきのattrs（ハッシュ）を渡して、必要なデータだけ抜粋して返す
def parse_tweet_data(tweet)
	tweet_data = Array.new
	tweet_data << tweet[:id]
	tweet_data << tweet[:created_at]
	tweet_data << tweet[:text]
	
	return tweet_data
end


#ここから実際の処理
MAX_COUNT = 200
page_num = 1
max_page = 2

data = Array.new
for i in page_num..max_page do
	#data << [i, "2016/04/16", "hogehoge"]
	timeline = get_timeline(client, MAX_COUNT, i)
	data += get_tweet(timeline)
	print "#{i} page	...done\n"
	sleep 1	#ちょっとウエイト
end

save_csv(data, "./output.csv")