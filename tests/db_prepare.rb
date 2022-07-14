require 'test/unit'
require 'pg'

class Database < Test::Unit::TestCase

  def test_database_connection
    conn = PG.connect(dbname: "postgres", host: '172.17.0.2', port: 5432, user: 'postgres', password: 'pass')

    assert_equal 'postgres', conn.db, 'Database connection successful'
    conn.close
  end
  
end