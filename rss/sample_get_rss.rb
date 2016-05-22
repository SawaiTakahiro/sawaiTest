#! ruby -Ku

=begin
 2016/05/22
 
 RSS読んでみる
=end


##########################################################################################
#共通の部分
require "fileutils"
require "CSV"
require "json"
require "rss"


#設定の読み込み
require "dotenv"
Dotenv.load

#自作汎用ライブラリはその後読む
require ENV["PATH_MY_LIBRARY"]



rss = RSS::Parser.parse(ENV["PATH_RSS"])

rss.items.each do |item|
	puts "#{item.title}	#{item.link}"
end
