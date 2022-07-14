require 'pg'
class DatabaseConnect
  DEFAULT_DATABASE = PG.connect(dbname: "postgres", host: 'db', user: 'postgres', password: 'pass')

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