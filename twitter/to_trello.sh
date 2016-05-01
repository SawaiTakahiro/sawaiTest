#!/bin/sh
echo "Trelloにカード追加するやつ：処理開始"
ruby get_tweet.rb
ruby convert_tweet.rb
ruby add_trello.rb
echo "処理の終了。"

