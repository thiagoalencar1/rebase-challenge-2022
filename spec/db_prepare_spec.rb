require 'spec_helper'

describe 'Data Base Prepare' do
  it 'Should connect to database successfully' do
    conn = PG.connect(dbname: 'postgres', host: '127.0.0.1', port: 5432,  user: 'postgres', password: 'pass')

    expect(conn.db).to eq('postgres') 

    conn.close
  end

  it 'Should create table successfully' do
    conn = PG.connect(dbname: 'postgres', host: '127.0.0.1', port: 5432,  user: 'postgres', password: 'pass')
    conn.exec_params("CREATE TABLE IF NOT EXISTS test_table(some_column INTEGER)")

    expect(conn.exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'").entries.last['table_name']).to eq('test_table')

    conn.exec("DROP TABLE test_table")
    conn.close
  end
end