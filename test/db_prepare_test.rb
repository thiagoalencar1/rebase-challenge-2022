require 'test/unit'
require 'pg'

class Database < Test::Unit::TestCase

  def test_database_connection
    conn = PG.connect(dbname: 'postgres', host: 'db', user: 'postgres', password: 'pass')

    assert_equal 'postgres', conn.db, 'Database connection successful'
    conn.close
  end

  def test_table_create
    conn = PG.connect(dbname: 'postgres', host: 'db', user: 'postgres', password: 'pass')
    conn.exec_params("CREATE TABLE test_table(some_column INTEGER)")

    assert_equal 'test_table', conn.exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'").first['table_name'], 'Table created'

    conn.exec("DROP TABLE test_table")
    conn.close
  end
end