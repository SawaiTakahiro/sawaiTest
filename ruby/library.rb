#! ruby -Ku

=begin
 2016/02/22
 
 汎用的な処理まとめ
=end

##########################################################################################
#全角か半角かチェック
#参考：http://cortyuming.hateblo.jp/entry/20140521/p1
def char_bytesize(char)
	char.bytesize == 1 ? 1 : 2
end

##########################################################################################
#ウインドウの更新処理
#引数で渡された文字列（data）を分解して、指定した座標（pos_x, pos_y）に更新して返す
#画面を表した配列windowを直接更新はしないようにした。呼び出しているそれぞれの処理のほうで明示的に上書きすること！
def add_window(data, window, pos_x, pos_y)
	x = pos_x
	y = pos_y
	
	i = 0
	data.each_char do |char|
		i += 1
		#print "i = #{i}	#{x}	#{y}	#{char}\n"
		
		#改行が入っていたら、次のところに
		#なおかつスキップしちゃう
		if char == "\n" then
			x = pos_x
			y += 1
			
			next
		end
		
		#全角なら、２文字分って扱いにする
		offset = 0
		if char_bytesize(char) == 2 then
			offset = 1
			
			#TODO:いい感じの順番を考える！
			window[y][x + 1] = ""	#詰める分の中身は空にする
		end
		
		window[y][x] = char	#行の中に列が入っているから、x, yだと逆になっちゃう！
		x += 1 + offset
		
	end
	
	return window
end

##########################################################################################
#右詰めしたりするための処理
#文字数のカウント
def get_text_length(text)
	return text.to_s.each_char.map{|c| char_bytesize(c)}.inject(:+)
end

#左詰め
def get_text_spaces_padding_l(text, max_len, padding_char)
	length = get_text_length(text)
	
	#はみ出そうだったらきりつめる
	if length > MAX_LEN_NAME then
		text = text[0..3]	#どうやってまるめようかな…
		
		length = get_text_length(text)	#改めてとりなおす
	end
	
	margin = max_len - length
	
	output = text.to_s
	output += padding_char * margin if margin > 0
	
	#空白詰めで返す
	return output
end

#右詰め
def get_text_spaces_padding_r(text, max_len, padding_char)
	length = get_text_length(text)
	
	#はみ出そうだったらきりつめる
	if length > MAX_LEN_NAME then
		text = text[0..3]	#どうやってまるめようかな…
		
		length = get_text_length(text)	#改めてとりなおす
	end
	
	margin = max_len - length
	#puts "margin	#{margin}"
	
	#右詰めの場合、スペースを足してから文字を入れる
	if margin > 0 then
		output = padding_char * margin + text.to_s
	else
		output = text
	end
	
	#空白詰めで返す
	return output
end

