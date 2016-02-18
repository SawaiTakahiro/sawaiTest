#! ruby -Ku

=begin
 2016/02/18
 
 標準出力に整形して表示してみる
 昔のドラクエみたいなウインドウっぽく表示してみたい。
=end

def show_window(data)
	puts data
end

data = Hash.new
data.store("HP", 100)
data.store("MP", 100)
data.store("Attack", 100)
data.store("Defense", 100)
data.store("Speed", 100)

show_window(data)


#サンプル
for i in 0..100 do
	printf "\e[1A\e[1A\e[1A\e[1A\e[1A \r"	if i > 0# ← カーソルを上に
	p i
	text =  "+--------+--------+\n"
	text += "| HP #{100 + i} | MP 200 |\n"
	text += "| HP 300 | MP 400 |\n"
	text += "+--------+--------+\n"
	
	sleep 0.1
	
	puts text
end
