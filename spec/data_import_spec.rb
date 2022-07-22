require 'spec_helper'
require './lib/db_manager'

describe 'DataImport' do
  after(:context) { DATABASE.exec("DROP TABLE exams_results_tests") }
  
  it 'should import data correctly in database' do
    DATABASE.exec("
      CREATE TABLE IF NOT EXISTS exams_results_tests (
        id SERIAL PRIMARY KEY,
        cpf varchar(20),
        name varchar(450),
        email varchar(100),
        birthdate varchar(100),
        address varchar(100),
        city varchar(100),
        state varchar(100),
        crm varchar(100),
        crm_state varchar(100),
        doctor_name varchar(100),
        doctor_email varchar(100),
        token_exame_result varchar(100),
        exame_date varchar(100),
        exame_type_limit varchar(100),
        exame_result varchar(100)
      );")

    table = CSV.read('spec/support/test_data.csv', col_sep: ';', headers: true)

    table.each do |result|
      DATABASE.exec_params("
        INSERT into exams_results_tests (cpf, name, email, birthdate, address, city, state,
          crm, crm_state, doctor_name, doctor_email,
          token_exame_result, exame_date, exame_type_limit, exame_result)

        VALUES (
          '#{result['cpf']}', '#{result['nome paciente']}', '#{result['email paciente']}',
          '#{result['data nascimento paciente']}', '#{result['endereço/rua paciente']}',
          '#{result['cidade paciente'].gsub('\'','')}', '#{result['estado patiente']}',
          '#{result['crm médico']}', '#{result['crm médico estado']}', '#{result['email médico']}',
          '#{result['token resultado exame']}', '#{result['data exame']}', '#{result['tipo exame']}',
          '#{result['limites tipo exame']}', '#{result['resultado tipo exame']}'
        );
      ")
    end

    expect(DATABASE.exec("SELECT * FROM exams_results_tests").count).to eq(7)
  end
end