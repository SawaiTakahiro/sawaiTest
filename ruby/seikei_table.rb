#! ruby -Ku

=begin
 2016/02/16
 
 標準出力に整形して表示してみる
=end

#表形式にして返す
def get_seikei_table(data, flag_header)
	#flag_headerがtrueなら、１行目を見出しとして扱ってあげる
	#true以外は無視
	
	#全角か半角かチェック
	#参考：http://cortyuming.hateblo.jp/entry/20140521/p1
	#たぶんこの中でしか使わない
	def char_bytesize(char)
		char.bytesize == 1 ? 1 : 2
	end
	
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
	output = ""	#出力用
	
	#ヘッダー、フッターを作る　※どっちも同じもの
	deco_line = ""
	list_max.each do |m|
		deco = "+" + "-" * m
		deco_line += deco
	end
	deco_line += "+\n"	#改行と、右端の+も足したら完成
	
	output += deco_line	#ヘッダー
	
	data.each_with_index do |record, r|
		for i in 0..column do
			length_max = list_max[i]
			length_coumn = record[i].to_s.each_char.map{|c| char_bytesize(c)}.inject(:+)
			margin = length_max - length_coumn
			
			output += "|" + record[i].to_s + " " * margin
		end
		
		output += "|\n"
		
		#１行目を見出しとして扱うときだけ
		if r == 0 && flag_header == true then
			output += deco_line	#ヘッダーの区切り用飾りも足す
		end
		
	end
	
	output += deco_line	#フッター
	
	return output
end

#テスト用
data = [["title", "購入金額", "備考"], ["a",0,"月"], ["あいうえお",10,"火曜"], ["ABCDEFGHIJK",200,"水曜日"]]
puts get_seikei_table(data, true)
