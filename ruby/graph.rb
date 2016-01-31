#! ruby -Ku

=begin
 2016/01/30
 
 グラフを表示してみるテスト。
 rubyでやってみるサンプル。
 
 http://rakkyoo.net/?p=631 より
=end
require "gnuplot"

Gnuplot.open do |gp|
	Gnuplot::Plot.new( gp ) do |plot|
		plot.title  'test'
		plot.ylabel 'ylabel'
		plot.xlabel 'xlabel'
		
		x = (-100..100).collect {|v| v.to_f}
		y = (-100..100).collect {|v| v.to_f ** 2}
		
		plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
			ds.with = "lines"
			ds.notitle
		end
	end
end