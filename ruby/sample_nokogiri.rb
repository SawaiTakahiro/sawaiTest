#! ruby -Ku

=begin
 nokogiriのサンプル
 http://morizyun.github.io/blog/ruby-nokogiri-scraping-tutorial/
 
 ヤフージャパンのタイトルを表示してみようよ〜なやつ
=end

require "open-uri"
require "fileutils"
require "nokogiri"


url = "http://www.yahoo.co.jp"

charset = nil
html = open(url) do |file|
	charset = file.charset
	file.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

p doc.title
