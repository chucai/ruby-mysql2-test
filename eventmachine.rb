require_relative 'common'
require 'eventmachine'
require 'mysql2/em'

# 参考: https://github.com/brianmario/mysql2/blob/master/examples/eventmachine.rb
# 使用 mysql eventmachine 插件，可以不阻塞的调用程序，返回数据后调用callback
EM.run do
  client1 = Mysql2::EM::Client.new OPTIONS
  defer1 = client1.query "SELECT sleep(3) as first_query"
  defer1.callback do |result|
    puts "Result: #{result.to_a.inspect}"
    EM.stop
  end

  client2 = Mysql2::EM::Client.new OPTIONS
  defer2 = client2.query "SELECT sleep(1) second_query"
  defer2.callback do |result|
    puts "Result: #{result.to_a.inspect}"
  end

end
