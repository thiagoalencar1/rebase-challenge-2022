require 'spec_helper'
require 'sidekiq/testing'
require './lib/clinical_exams'
Sidekiq::Worker.clear_all
Sidekiq::Testing.inline!

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
  end
end