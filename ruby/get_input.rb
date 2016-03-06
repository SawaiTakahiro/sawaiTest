#! ruby -Ku
=begin
 2016/03/04
 
 コマンドライン上であれこれしたい〜って場合、インタラクティブな処理したい。
 なので、入力を受け取ってあれこれしてみる
=end

#状態の定義
MODE_START	= 0
MODE_END	= 999
CORSOR_UP = "\e[1A"

#ゲームのシーンみたいな感じで管理してみるか
mode_num = 0

#コマンドの定義
COMMAND_EXIT = "exit"

#存在するコマンドをまとめておく
LIST_COMMAND = Hash.new
LIST_COMMAND.store("exit",		MODE_END)
LIST_COMMAND.store("end",		MODE_END)
LIST_COMMAND.store("e",			MODE_END)
LIST_COMMAND.store("quit",		MODE_END)


##################################################
#終了時にやること
def todo_end()
	print "処理を終了します。\n"
end

#コマンドが見つからなかったら
def command_not_found(command)
	print CORSOR_UP
	print "#{command.chomp} コマンドが見つかりません。正しいコマンドを入力してください。\n"
	print "存在するコマンド：#{LIST_COMMAND.keys.join(", ")}\n"
end


##################################################
print "コマンドを入力してください。\n"
while command = STDIN.gets
	#入力されたコマンドのチェック
	result_command = LIST_COMMAND[command.chomp]
	
	#nilじゃなければモードの変更をする
	unless result_command == nil then
		mode_num = result_command
	else
		command_not_found(command)
	end
	
	
	
	mode_num = MODE_END if command.chomp == COMMAND_EXIT
	
	#状態のチェック
	#終了モードなら抜ける
	if mode_num == MODE_END
		todo_end()
		break
	end
end

