require_relative 'common'

##
#在一个程序中，如果使用同一个 connection，其中一条SQL被阻塞了，那么
#整个程序都会被阻塞
# 对于一个connection 在其没有获得返回值之前，是不能执行任何的SQL的
# 否则会报错：
# This connection is still waiting for a result, try again once you have the result (Mysql2::Error
#
#

client0 = Mysql2::Client.new(OPTIONS)
# 设置 async 为 true 后，查询会马上返回, 不会阻塞程序
client0.query("SELECT SLEEP(5)", :async => true)


client1 = Mysql2::Client.new(OPTIONS)
results = client1.query(SQL)
puts results.count
