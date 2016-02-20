#! ruby -Ku

=begin
 2016/02/18
 
 標準出力に整形して表示してみる
 昔のドラクエみたいなウインドウっぽく表示してみたい。
=end

##################################################

def get_text_length(text)
	#全角か半角かチェック
	#参考：http://cortyuming.hateblo.jp/entry/20140521/p1
	#結構使うかもしれない。持ち方を考える
	def char_bytesize(char)
		char.bytesize == 1 ? 1 : 2
	end
	
	return text.to_s.each_char.map{|c| char_bytesize(c)}.inject(:+)
end


def show_window(data)
	puts data
end

#左詰め
def get_text_spaces_padding_l(text, max_len)
	length = get_text_length(text)
	
	#はみ出そうだったらきりつめる
	if length > MAX_LEN_NAME then
		text = text[0..3]	#どうやってまるめようかな…
		
		length = get_text_length(text)	#改めてとりなおす
	end
	
	margin = max_len - length + 1
	
	output = text.to_s
	output += " " * margin if margin > 0
	
	#空白詰めで返す
	return output
end

#→詰め
def get_text_spaces_padding_r(text, max_len)
	length = get_text_length(text)
	
	#はみ出そうだったらきりつめる
	if length > MAX_LEN_NAME then
		text = text[0..3]	#どうやってまるめようかな…
		
		length = get_text_length(text)	#改めてとりなおす
	end
	
	margin = max_len - length + 1
	#puts "margin	#{margin}"
	
	#右詰めの場合、スペースを足してから文字を入れる
	if margin > 0 then
		output = " " * margin + text.to_s
	else
		output = text
	end
	
	#空白詰めで返す
	return output
end

#サイズの上限定義	半角で
MAX_LEN_NAME	= 8
MAX_LEN_STATUS	= 4


##################################################
#ダミーのステータス
data = Hash.new
data.store("name", "さわい789abcdefg")
data.store("HP", 9999)
data.store("MP", 99)
data.store("Attack", 100)
data.store("Defense", 100)
data.store("Speed", 100)

#表示用に変換する
name = get_text_spaces_padding_l(data["name"], MAX_LEN_NAME)
hp = get_text_spaces_padding_r(data["HP"], MAX_LEN_STATUS)
mp = get_text_spaces_padding_r(data["MP"], MAX_LEN_STATUS)

attack = get_text_spaces_padding_r(data["Attack"], MAX_LEN_STATUS)
defense = get_text_spaces_padding_r(data["Defense"], MAX_LEN_STATUS)
speed = get_text_spaces_padding_r(data["Speed"], MAX_LEN_STATUS)



#画面の定義
window = <<"EOS"
+----------+----------+----------+----------+----------+----------+----------+
| #{name}| HP #{hp} | MP #{mp} | MP #{mp} | AT #{attack} | DF #{defense} | AG #{speed} |
+----------+----------+----------+----------+----------+----------+----------+

EOS

#それを表示してみる
puts window

