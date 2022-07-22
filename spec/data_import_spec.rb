require 'spec_helper'
require './lib/db_manager'

describe 'DataImport' do
  before(:each) { DbManager.reset }
  after(:each) { DbManager.drop }
  
  it 'should import data correctly in database' do
    DbManager.create
    table = CSV.read('spec/support/test_data.csv', col_sep: ';', headers: true)

    DbManager.import(table)

    expect(DbManager.find_all.count).to eq(7)
  end
end