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

#自分の定義
#me = Trello::Member.find("me")
my_list = Trello.client.find(:list, ENV["TRELLO_GARBAGE_ID"])
my_list.cards.each do |card|
	card.delete
end
