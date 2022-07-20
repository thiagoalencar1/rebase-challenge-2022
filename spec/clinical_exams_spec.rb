
require 'spec_helper'
require 'csv'
require 'json'
require './lib/db_connect'
require './lib/clinical_exams'

describe 'ClinicalExams' do
  after(:each) { DATABASE.exec("DROP TABLE exams_results_tests") }

  context '#all_exams' do
    it 'should return all exams' do
      result = [{"id":"1","cpf":"048.973.170-88","name":"Emilly Batista Neto","email":"gerald.crona@ebert-quigley.com","birthdate":"2001-03-11","address":"165 Rua Rafaela","city":"Ituverava","state":"Alagoas","crm":"B000BJ20J4","crm_state":"PI","doctor_name":"Maria Luiza Pires","doctor_email":"denna@wisozk.biz","token_exam_result":"IQCZ17","exam_date":"2021-08-05","exam_type":"ácido úrico","exam_type_limit":"15-61","exam_result":"2"}]

      DATABASE.exec("
        CREATE TABLE IF NOT EXISTS exams_results_tests (
          id SERIAL PRIMARY KEY, cpf varchar(20), name varchar(450),
          email varchar(100), birthdate varchar(100), address varchar(100),
          city varchar(100), state varchar(100),
          crm varchar(100), crm_state varchar(100), doctor_name varchar(100),
          doctor_email varchar(100), token_exam_result varchar(100),
          exam_date varchar(100), exam_type varchar(100),
          exam_type_limit varchar(100), exam_result varchar(100)
        );")

      table = CSV.read('./spec/support/test_data_single.csv', col_sep: ';', headers: true)
      
      table.each do |row|
        DATABASE.exec_params("
          INSERT into exams_results_tests (
            cpf, name, email, birthdate, address, city, state,
            crm, crm_state, doctor_name, doctor_email,
            token_exam_result, exam_date, exam_type, exam_type_limit, exam_result)
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)",
          [
           row['cpf'], row['nome paciente'], row['email paciente'], row['data nascimento paciente'], row['endereço/rua paciente'],
           row['cidade paciente'].gsub('\'',''), row['estado patiente'], row['crm médico'], row['crm médico estado'], row['nome médico'],
           row['email médico'], row['token resultado exame'], row['data exame'], row['tipo exame'], row['limites tipo exame'], row['resultado tipo exame']
          ]
        )
      end

      expect(ClinicalExams.all_exams(DATABASE.exec("SELECT * FROM exams_results_tests"))).to eq(result.to_json)
    end

    it 'and there is not exams' do
      result = 'Não foram encontrados exames clínicos'

      DATABASE.exec("
        CREATE TABLE IF NOT EXISTS exams_results_tests (
          id SERIAL PRIMARY KEY, cpf varchar(20), name varchar(450),
          email varchar(100), birthdate varchar(100), address varchar(100),
          city varchar(100), state varchar(100),
          crm varchar(100), crm_state varchar(100), doctor_name varchar(100),
          doctor_email varchar(100), token_exam_result varchar(100),
          exam_date varchar(100), exam_type varchar(100),
          exam_type_limit varchar(100), exam_result varchar(100)
        );")

      expect(ClinicalExams.all_exams(DATABASE.exec("SELECT * FROM exams_results_tests"))).to eq(result)
    end
  end

  context '#show_exam' do
    it 'should return all exams with same token' do
      result = File.read('./spec/support/clinical_exam_detail.json')
      DATABASE.exec("
        CREATE TABLE IF NOT EXISTS exams_results_tests (
          id SERIAL PRIMARY KEY, cpf varchar(20), name varchar(450),
          email varchar(100), birthdate varchar(100), address varchar(100),
          city varchar(100), state varchar(100),
          crm varchar(100), crm_state varchar(100), doctor_name varchar(100),
          doctor_email varchar(100), token_exam_result varchar(100),
          exam_date varchar(100), exam_type varchar(100),
          exam_type_limit varchar(100), exam_result varchar(100)
        );")

      table = CSV.parse('./clinical_exam_detail.csv', col_sep: ';', headers: true)
      
      table.each do |row|
        DATABASE.exec_params(
          "INSERT into exams_results_tests (
            cpf, name, email, birthdate, address, city, state,
            crm, crm_state, doctor_name, doctor_email,
            token_exam_result, exam_date, exam_type, exam_type_limit, exam_result)
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)",
          [
           row['cpf'], row['nome paciente'], row['email paciente'], row['data nascimento paciente'], row['endereço/rua paciente'],
           row['cidade paciente'].gsub('\'',''), row['estado patiente'], row['crm médico'], row['crm médico estado'], row['nome médico'],
           row['email médico'], row['token resultado exame'], row['data exame'], row['tipo exame'], row['limites tipo exame'], row['resultado tipo exame']
          ]
        )
      end

      expect(ClinicalExams.show_exam('IQCZ17').to_json).to eq(result)
    end
  end
end

