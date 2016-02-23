#! ruby -Ku

=begin
 2016/02/22
 
 標準出力に整形して表示してみる
 昔のドラクエみたいなウインドウっぽく表示してみたい。
 
 シューティングとかのサンプルでよくある、配列でマップを作ってみる的な方法にしてみたバージョン
=end

require "./library.rb"


##################################################

#画面サイズ
WIDTH		= 20
HEIGHT	= 20
DEFAULT_VALUE = "."	#bashだとスペースが省かれるっぽいので、確認用としてアンダーバーにした
CORSOR_UP = "\e[1A"

#画面の定義
#http://blog.cototoco.net/work/201405/ruby-%E9%85%8D%E5%88%97/	参考：オブジェクトIDが同じになってひどいことになる。
window = Array.new(HEIGHT, DEFAULT_VALUE).map{Array.new(WIDTH, DEFAULT_VALUE)}

attack = 0


#以下は、ためしに書き込んでみるデータ
hoge = <<"EOS"
+------+
|さわい|
+------+
EOS

fuga = <<"EOS"
+---+----+
|atk| #{attack}|
+---+----+
EOS


#サイズの上限定義	半角で
MAX_LEN_NAME	= 8
MAX_LEN_STATUS	= 2
DEFALUT_PADDING_CHAR = " "

p "\n"*3

for i in 0..10 do
	attack = get_text_spaces_padding_r(i , MAX_LEN_STATUS, DEFALUT_PADDING_CHAR)
	
	hoge = <<"EOS"
+------+
|さわい|
+------+
EOS

fuga = <<"EOS"
+---+----+
|atk| #{attack}|
+---+----+
EOS
	window = add_window(hoge, window, 0, 0)
	window = add_window(fuga, window, 7, 0)
	
	print CORSOR_UP * HEIGHT, "\r"
	
	#表示してみる
	window.each do |row|
		p row.join
	end
	
	sleep 0.1
	
end

