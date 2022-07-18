require 'spec_helper'
require 'pg'
require 'csv'

describe 'Data Import' do
  it 'Sould import data correctly in database' do
    conn = PG.connect(dbname: 'postgres', host: '127.0.0.1', port: 5432,  user: 'postgres', password: 'pass')
    conn.exec("
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

    table = CSV.read('spec/test_data.csv', col_sep: ';', headers: true)

    table.each do |result|
      conn.exec_params("
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

    expect(conn.exec("SELECT * FROM exams_results_tests").count).to eq(7)
   
    conn.exec_params("DROP TABLE exams_results_tests")
  end
end