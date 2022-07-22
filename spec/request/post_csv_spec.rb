require 'spec_helper'

RSpec.describe 'POST /import' do
  let(:app) { ClinicalExamsApi.new }
  before(:each) { DbManager.reset }
  after(:each) { DbManager.drop }

  context 'post csv file' do
    it 'with success' do
      file = File.open('spec/support/test_data.csv')

      post '/import', file

      expect(last_response.status).to eq 200
      expect(DbManager.find_all.first['cpf']).to eq '048.973.170-88'
    end


    it 'and there is no file sent' do
      
      post '/import'

      expect(last_response.status).to eq 412
      expect(last_response.body).to eq '{ Por favor escolha o arquivo a ser enviado. }'.to_json
    end
  end
end