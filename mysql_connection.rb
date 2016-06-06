require 'mysql2'

options = {
  host: '192.168.99.100',
  database: 'test_db',
  port: 3306,
  username: 'root',
  password: '123456'
}
sql = 'SELECT * FROM users'
client = Mysql2::Client.new(options)
results = client.query(sql)

puts results.count
