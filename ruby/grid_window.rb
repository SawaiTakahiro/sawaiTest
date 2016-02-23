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
		
		window[y][x] = char	#行の中に列が入っているから、x, yだと逆になっちゃう！
		x += 1
	end
	
	return window
end

##################################################

#画面サイズ
WIDTH		= 20
HEIGHT	= 20
DEFAULT_VALUE = "_"	#bashだとスペースが省かれるっぽいので、確認用としてアンダーバーにした

#画面の定義
#http://blog.cototoco.net/work/201405/ruby-%E9%85%8D%E5%88%97/	参考：オブジェクトIDが同じになってひどいことになる。
window = Array.new(HEIGHT, DEFAULT_VALUE).map{Array.new(WIDTH, DEFAULT_VALUE)}


#以下は、ためしに書き込んでみるデータ
hoge = <<"EOS"
+---+
|999|
+---+
EOS

window[0][0] = "a"
window[0][1] = "b"
window[3][3] = "c"


window = add_window(hoge, window, 0, 0)
window = add_window(hoge, window, 4, 4)

#表示してみる
window.each do |row|
	#print row.join, "\n"
	print row.join("."), "\n"
end
