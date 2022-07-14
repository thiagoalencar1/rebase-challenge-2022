require 'pg'
class DatabaseConnect
  DEFAULT_DATABASE = PG.connect(dbname: 'postgres', host: '127.0.0.1', port: 5432,  user: 'postgres', password: 'pass')

  def connect(database = DEFAULT_DATABASE)
    @connection = database
  end

  def disconnect
    @connection.close
  end

  def query(sql)
    @connection.exec(sql)
  end
end