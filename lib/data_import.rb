require 'csv'
require_relative './db_prepare'

table = CSV.read('data.csv', col_sep: ';', headers: true)

table.each do |result|
  DATABASE.exec_params("
    INSERT into exams_results (
      cpf, name, email, birthdate, address, city, state,
      crm, crm_state, doctor_name, doctor_email,
      token_exam_result, exam_date, exam_type, exam_type_limit, exam_result)

    VALUES (
      '#{result['cpf']}',
      '#{result['nome paciente']}',
      '#{result['email paciente']}',
      '#{result['data nascimento paciente']}',
      '#{result['endereço/rua paciente']}',
      '#{result['cidade paciente'].gsub('\'','')}',
      '#{result['estado patiente']}',

      '#{result['crm médico']}',
      '#{result['crm médico estado']}',
      '#{result['nome médico']}',
      '#{result['email médico']}',

      '#{result['token resultado exame']}',
      '#{result['data exame']}',
      '#{result['tipo exame']}',
      '#{result['limites tipo exame']}',
      '#{result['resultado tipo exame']}'
    );
  ")
end