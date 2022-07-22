
require 'spec_helper'
require 'json'
require './lib/clinical_exams'

RSpec.describe 'ClinicalExams' do
  before(:each) { DbManager.reset }
  after(:each) { DbManager.drop }

  context '#all_exams' do
    it 'should return all exams in json format' do
      result = [{"id":"1","cpf":"048.973.170-88","name":"Emilly Batista Neto","email":"gerald.crona@ebert-quigley.com","birthdate":"2001-03-11","address":"165 Rua Rafaela","city":"Ituverava","state":"Alagoas","crm":"B000BJ20J4","crm_state":"PI","doctor_name":"Maria Luiza Pires","doctor_email":"denna@wisozk.biz","token_exam_result":"IQCZ17","exam_date":"2021-08-05","exam_type":"ácido úrico","exam_type_limit":"15-61","exam_result":"2"}]
      table = CSV.read('./spec/support/test_data_single.csv', col_sep: ';', headers: true)
      DbManager.import(table)

      expect(ClinicalExams.all_exams).to eq(result.to_json)
    end

    it 'and there is not exams' do
      result = 'Não foram encontrados exames clínicos'
      DbManager.create

      expect(ClinicalExams.all_exams(DbManager.find_all)).to eq(result)
    end
  end

  context '#show_exam' do
    it 'should return all exams with same token' do
      result = File.read('./spec/support/clinical_exam_detail.json')
      table = CSV.read('./spec/support/clinical_exam_detail.csv', col_sep: ';', headers: true)
      
      DbManager.import(table)

      expect(ClinicalExams.show_exam('IQCZ17').to_json).to eq(result)
    end
  end
end

