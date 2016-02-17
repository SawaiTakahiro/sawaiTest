#! ruby -Ku

=begin
 2016/02/16
 
 標準出力に整形して表示してみる
=end

#表形式にして返す

#全角か半角かチェック
#参考：http://cortyuming.hateblo.jp/entry/20140521/p1
def char_bytesize(char)
	char.bytesize == 1 ? 1 : 2
end

def print_seikei_table(data)
	column = data[0].length - 1	#配列のインデックスなので
	
	list_max_length = Array.new
	
	#１カラムごとの処理
	for i in 0..column do
		#そのカラムのデータを抜き出して
		temp = data.map{|data| data[i]}
		
		#１番長い文字を調べる
		list_max_length = Array.new
		temp.each do |text|
			#文字にしないとだめ
			list_max_length << text.to_s.each_char.map {|c| char_bytesize(c)}.inject(:+)
		end
		
		p list_max_length.max
		
	end
end

data = [["a",0,"月"], ["あいうえお",10,"火曜"], ["ABCDEFGHIJK",200,"水曜日"]]
print_seikei_table(data)
