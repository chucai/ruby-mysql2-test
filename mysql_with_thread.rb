require_relative 'common'
require 'thread'

# Mysql2 理论上只能new 一个 connection, 没有使用连接池
client = Mysql2::Client.new OPTIONS

##
#/Users/xudonghe/.rvm/gems/ruby-2.3.0/gems/mysql2-0.4.4/lib/mysql2/client.rb:107:in `_query': This connection is in use by: #<Thread:0x007f853304dc50@mysql_with_thread.rb:8 sleep> (Mysql2::Error)
# 下面的代码会抛出这个错误，因为 connection 太少了
2.times.map do |i|
  Thread.new {
    puts i
    result = client.query("SELECT sleep(5)") # mysql阻塞5秒钟
  }
end.map(&:join)

# 增加了 mutex 可以解决这个问题
mutex = Mutex.new
2.times.map do |i|
  Thread.new {
    puts i
    mutex.lock {
      result = client.query("SELECT sleep(5)") # mysql阻塞5秒钟
    }
  }
end.map(&:join)

