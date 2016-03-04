#! ruby -Ku
=begin
 2016/03/04
 
 コマンドライン上であれこれしたい〜って場合、インタラクティブな処理したい。
 なので、入力を受け取ってあれこれしてみる
=end

#状態の定義
MODE_START	= 0
MODE_END	= 999

#ゲームのシーンみたいな感じで管理してみるか
mode_num = 0

##################################################
#終了時にやること
def todo_end()
	print "処理を終了します。\n"
end


while command = STDIN.gets
	mode_num = MODE_END if command.chomp == "exit"
	print "text	: ", command
	
	#状態のチェック
	#終了モードなら抜ける
	if mode_num == MODE_END
		todo_end
		break
	end
end

