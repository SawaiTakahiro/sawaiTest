#! ruby -Ku

=begin
 2016/04/15
 twitterのAPI使って見るテスト
=end


##########################################################################################
#共通の部分

require "fileutils"
require "CSV"
require "json"

require "trello"
require "dotenv"

include Trello
include Trello::Authorization

require "sqlite3"
include SQLite3

#APIキーとかを読み込んで設定する
Dotenv.load
Trello.configure do |config|
	config.consumer_key = ENV["TRELLO_CONSUMER_KEY"]
	config.consumer_secret = ENV["TRELLO_CONSUMER_SECRET"]
	config.oauth_token = ENV["TRELLO_OAUTH_TOKEN"]
end

#こっちはTrelloの設定
Trello.configure do |config|
	config.consumer_key = ENV["TRELLO_CONSUMER_KEY"]
	config.consumer_secret = ENV["TRELLO_CONSUMER_SECRET"]
	config.oauth_token = ENV["TRELLO_OAUTH_TOKEN"]
end

##########################################################################################
print "処理の開始をします。\n"
db = SQLite3::Database.new("./arcive.db")	#ファイルなかったら作られるから平気

#カード作る用のデータを取得
MAX_COUNT = 100	#100で十分かも。多すぎると捌くのだるい&重くなる
query = "select * from arcive where flag = 'false' limit #{MAX_COUNT};"
list_tweet = db.execute(query)
length_list = list_tweet.length

db.transaction do
	list_tweet.each_with_index do |array, i|
		id = array[0]
		date = array[1]
		card_name = array[2][0..20]	#長くなるので本文から20文字まで
		text = "#{array[2]}\n#{array[3]}"	#ディスクレプションはURLも入れる
		url = array[3]
		#Trelloにカード追加する
		Card.create(:name => card_name, :list_id => ENV["TRELLO_LIST_ID"], desc:text, :url => url, due: date,)
		
		#カードを作ったものは処理済みに
		query_update = "update arcive set flag = 'true' where id = '#{id}';"
		db.execute(query_update)
		
		#進捗表示
		print "\r 処理中 : #{i} / #{length_list} のカード作成"
	end
end

print "\n処理が完了しました。\n"