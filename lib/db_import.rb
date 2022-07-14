require 'csv'
require 'pg'

conn = PG.connect(dbname: "postgres", host: '172.22.0.2', port: 5432, user: 'postgres', password: 'pass')

table = CSV.read('data.csv', col_sep: ';', headers: true)

table.each do |result|
  conn.exec_params("
    INSERT into client (cpf, name, email, birthdate, address, city, state,
      crm, crm_state, doctor_name, doctor_email,
      token_exame_result, exame_date, exame_type_limit, exame_result)

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
      '#{result['email médico']}',
      '#{result['token resultado exame']}',
      '#{result['data exame']}',
      '#{result['tipo exame']}',
      '#{result['limites tipo exame']}',
      '#{result['resultado tipo exame']}'
    );
  ")
end