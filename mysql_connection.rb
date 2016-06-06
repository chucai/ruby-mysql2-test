require_relative 'common'

client = Mysql2::Client.new(OPTIONS)
results = client.query(SQL)

puts results.count
