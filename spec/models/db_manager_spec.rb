require 'spec_helper'
require './lib/db_manager'

RSpec.describe do
  context 'Data Base Prepare' do
    after(:context) { DATABASE.exec("DROP TABLE test_table") }

    it 'Should connect to database successfully' do
      expect(DATABASE.db).to eq('postgres')
    end

    it 'Should create table successfully' do
      DATABASE.exec_params("CREATE TABLE IF NOT EXISTS test_table(some_column INTEGER)")

      expect(DATABASE.exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'").entries.last['table_name']).to eq('test_table')
    end
  end

  context 'DataImport' do
    before(:each) { DbManager.reset }
    after(:each) { DbManager.drop }
    
    it 'should import data correctly in database' do
      DbManager.create
      table = CSV.read('spec/support/test_data.csv', col_sep: ';', headers: true)

      DbManager.import(table)

      expect(DbManager.find_all.count).to eq(7)
      expect(DbManager.find_all.first['cpf']).to eq('048.973.170-88')
      expect(DbManager.find_all.first['name']).to eq('Emilly Batista Neto')
    end
  end
end