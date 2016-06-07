require_relative 'connection_pool'

# 我讲连接数修改为3 ，一次启动20 个查询，看看效果

threads = []

20.times do
  threads << Thread.new do
    ConnectionPool.instance.execute do |conn|
      result = conn.query("SELECT sleep(1) AS test_column")
      puts result.to_a.inspect
    end
  end
end

threads.map(&:join)
