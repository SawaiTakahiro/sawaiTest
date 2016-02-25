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
WIDTH		= 40
HEIGHT	= 30
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

for i in 0..4 do
	attack = get_text_spaces_padding_r(i , MAX_LEN_STATUS, DEFALUT_PADDING_CHAR)
	
	#TODO:ループの中に無理やりヒアドキュメント埋め込んでるの何とかする
	#作った時点のattackが入ってしまうので、今は無理やり入れ込んでいる
	#変数を動的に差し替えたいときは、その都度、生成しないとダメみたい。
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
	
	#TODO:ここもやりかたを何とかする
	#まだ書き込んでないのにカーソル位置を戻していたから、ぐわーって表示されてた
	print CORSOR_UP * HEIGHT, "\r"	if i > 0
	
	#表示してみる
	window.each do |row|
		p row.join
	end
	
	sleep 0.1
end

