#! ruby -Ku

=begin
 2016/04/16
 twitterのAPI使って見るテスト
 
 「取得→csv保存したやつ」を読み込んで加工するところまで。
=end

##########################################################################################
#共通の部分
require "Twitter"
require "./library.rb"

require "sqlite3"
include SQLite3

TABLE_NAME = "fuga"

#つぶやきを、見出しとアドレスに分けられたら分ける
def text_split(text)
	matchdata = text.match(/(.*.)(http.*.)/)
	
	#分けられなそうなデータはそのまま
	#アドレスを空で戻している
	if matchdata == nil
		title = text
		address = ""
	else
		title = matchdata[1]
		address = matchdata[2]
	end
	
	return [title, address]
end

#実際の処理
list_tweet = read_csv("./output.csv")

db = SQLite3::Database.new("./arcive.db")	#ファイルなかったら作られるから平気
db.execute("create table if not exists #{TABLE_NAME}(id primary key, date, title, address);")	#初期化用テーブル

db.transaction do
	list_tweet.each do |tweet|
		id = tweet[0]
		date = tweet[1]
		
		#つぶやきの内容は、分けられたら分ける
		data = text_split(tweet[2])
		title = data[0].gsub(/'|’/, "’")	#半角'を全角にエスケープしとく
		#なんかブログ名とかで'とか`とか使われていると取り込めないので注意。とりあえず適当な文字に置き換えている
		address = data[1]
		
		query = "insert or ignore into #{TABLE_NAME} values('#{id}', '#{date}', '#{title}', '#{address}')"
		db.execute(query)
	end
end

