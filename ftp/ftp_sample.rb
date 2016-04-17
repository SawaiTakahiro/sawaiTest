#! ruby -Ku

=begin
 2016/04/16
 twitterのAPI使って見るテスト
 
 「あとで消す」に入っているカードを消すスクリプト
=end


##########################################################################################
#共通の部分

require "net/ftp"
require "fileutils"
require "CSV"
require "json"

require "dotenv"

#設定
Dotenv.load
url       = ENV["URL"]
port      = ENV["PORT"]
from_dir  = ENV["FROM_DIR"]
dest_dir  = ENV["DEST_DIR"]
user      = ENV["USER_NAME"]
pass      = ENV["PASS"]

#p url,port,user,pass
#exit

ftp = Net::FTP.new
ftp.connect(url, port)
ftp.login(user, pass)
ftp.binary = true

ftp.chdir from_dir
file_name = "hogehoge.txt"
ftp.get(file_name.force_encoding('utf-8'), File.join(dest_dir, file_name))

#後始末
p "ftp終了"
ftp.quit

##########################################################################################


