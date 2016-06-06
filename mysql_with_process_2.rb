require_relative 'common'
require 'thread'

##
#证明一个事情，如果 max_connections = 2
# 1. 它的意思是 mysql 最多同时允许 2 个connection 处于运行状态
# 但由于 select sleep(15) 在 mysql 中处于 user sleep 状态，这个时候
# mysql 是可以接受新的connection的
# 2. 如果连接数过多，会抛出 many connections 的错误
#
client = Mysql2::Client.new OPTIONS
result = client.query("SELECT sleep(15)")

