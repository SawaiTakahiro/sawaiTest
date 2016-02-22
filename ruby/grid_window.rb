#! ruby -Ku

=begin
 2016/02/22
 
 標準出力に整形して表示してみる
 昔のドラクエみたいなウインドウっぽく表示してみたい。
 
 シューティングとかのサンプルでよくある、配列でマップを作ってみる的な方法にしてみたバージョン
=end

##################################################
def add_window(data, window, pos_x, pos_y)
	x = pos_x
	y = pos_y
	
	data.each_char do |char|
		print "#{x}	#{y}	#{char}\n"
		
		#改行が入っていたら、次のところに
		if char == "\n" then
			x = pos_x
			y += 1
		else
			#window[x][y] = char
			window[x][y] = "1"
			x += 1
		end
	end
	
	p window
	
	return window
end

##################################################

#画面サイズ
WIDTH		= 10
HEIGHT	= 10

#画面の定義
column = Array.new(WIDTH, "0")	#初期化用に作ってる。中身も仮で0にしてるけど、今度変える
window = Array.new(HEIGHT, column)


#ためしに書き込んでみるデータ
hoge = <<"EOS"
+---+
|999|
+---+
EOS

window = add_window(hoge, window, 2, 2)

#表示してみる
window.each do |row|
	p row.join
end
