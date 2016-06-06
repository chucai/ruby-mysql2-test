require_relative 'common'
require 'thread'

##
#没有在配置文件中显示 connections 连接数的时候，都是可以连接的
#应该有一个默认的连接数最大值
18.times.map do
  Thread.new do
    client = Mysql2::Client.new OPTIONS
    result = client.query("SELECT sleep(15)")
  end
end.map(&:join)

