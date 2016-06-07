require_relative 'common'

##
#在一个程序中，如果使用不同一个 connection，其中一条SQL被阻塞了，那么
#整个程序都会被阻塞

# client0的query会阻塞程序5秒时间
client0 = Mysql2::Client.new(OPTIONS)
client0.query("SELECT SLEEP(5)")

# client 1 用于能马上查询到的数据
client1 = Mysql2::Client.new(OPTIONS)
results1 = client1.query(SQL)
puts results1.count
