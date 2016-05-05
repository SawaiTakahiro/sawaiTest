#! ruby -Ku

=begin
 2016/05/05
 必要な硬貨の枚数を数えてみるやつ
=end

money = (rand() * 1000).to_i
p "money : #{money}"

list_okane = [500, 100, 50, 10, 5, 1]

kotae = Hash.new
list_okane.each do |okane|
	#必要な硬貨枚数を答えに足す
	kotae.store(okane, (money / okane).to_i)
	
	#お金を減らす
	money %= okane
	
end

kotae.map{|hoge| p hoge}