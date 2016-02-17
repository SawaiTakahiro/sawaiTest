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
	
	list_max = Array.new
	
	#カラムの要素ごとに、最大の文字数を調べる
	for i in 0..column do
		#そのカラムのデータを抜き出して
		temp_data = data.map{|data| data[i]}
		
		#１番長い文字を調べる
		temp_list_length = Array.new
		temp_data.each do |text|
			#文字にしないとだめ
			#その文字を、１文字ごとに全角か半角か調べて、合計して作業用リストに入れる
			#ちょっと見慣れない書き方だけど…
			temp_list_length << text.to_s.each_char.map{|c| char_bytesize(c)}.inject(:+)
		end
		
		list_max << temp_list_length.max
	end
	
	#それぞれをスペースで埋める
	data.each do |record|
		for i in 0..column do
			length_max = list_max[i]
			length_coumn = record[i].to_s.each_char.map{|c| char_bytesize(c)}.inject(:+)
			margin = length_max - length_coumn
			print record[i].to_s + " " * margin + " |"
		end
		
		print "\n"
	end
	
end

data = [["a",0,"月"], ["あいうえお",10,"火曜"], ["ABCDEFGHIJK",200,"水曜日"]]
print_seikei_table(data)
