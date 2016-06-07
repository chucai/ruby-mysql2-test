##
# 连接池的实现思路
# 1. 初始化的时候，一次性初始化多个连接池
# 2. 将所有的连接放到一个 Queue 里面
# 3. 每次使用的时候，将连接池从对列中弹出
# 4. 用完归还
# 5. 为了保证在程序中，只有一个对象，所以，需要使用单例模式
#

require 'singleton'
require_relative 'common'

class ConnectionPool
  include Singleton

  MAX_CONNECTION_NUMBERS = 3 #20 # 一次创建20个连接

  def initialize
    @queue = [] # 队列，用于保存连接
    @active_connection_number = 0
    @mutex = Mutex.new

    MAX_CONNECTION_NUMBERS.times do
      @queue << spawn_connection
      @active_connection_number += 1
    end
  end

  def execute
    return unless block_given? # 如果没有给block ，则直接返回

    begin
      connection = get_connection # 获取当前可以执行的connection
      yield connection
      revert connection
    rescue Exception => e
      $stdout.puts e
      @mutex.synchronize do
        @active_connection_number -= 1
      end
      connection.close
      raise e
    end
      $stdout.puts "现在一共有#{@active_connection_number}个活跃连接"
  end

  private

  def spawn_connection
    Mysql2::Client.new(OPTIONS)
  end

  def get_connection
    @mutex.synchronize {
      if @queue.size > 0
        @active_connection_number -= 1
        return @queue.pop
      end
    }
    # 如果没有获得连接，就继续等待，直到获得连接为止
    sleep 1
    get_connection
  end

  def revert(connection)
    @mutex.synchronize do
      @active_connection_number += 1
      @queue << connection
    end
  end

end
