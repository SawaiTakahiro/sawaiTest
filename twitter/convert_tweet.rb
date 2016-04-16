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

list_tweet = read_csv("./output.csv")
list_tweet.each do |tweet|
	id = tweet[0]
	date = tweet[1]
	
	#つぶやきの内容は、分けられたら分ける
	data = text_split(tweet[2])
	title = data[0]
	address = data[1]
	
	p id, date, title, address
	break
end
