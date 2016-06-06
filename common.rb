require 'mysql2'

OPTIONS = {
  host: '192.168.99.100',
  database: 'test_db',
  port: 3306,
  username: 'root',
  password: '123456'
}
SQL = 'SELECT * FROM users'
