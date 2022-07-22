require 'spec_helper'
require './lib/db_manager'

describe 'Data Base Prepare' do
  after(:context) { DATABASE.exec("DROP TABLE test_table") }

  it 'Should connect to database successfully' do
    expect(DATABASE.db).to eq('postgres')
  end

  it 'Should create table successfully' do
    DATABASE.exec_params("CREATE TABLE IF NOT EXISTS test_table(some_column INTEGER)")

    expect(DATABASE.exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'").entries.last['table_name']).to eq('test_table')
  end
end