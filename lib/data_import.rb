require 'csv'
require_relative './db_prepare'

def data_import(table)
  table.each do |row|
    DATABASE.exec_params("
      INSERT into exams_results (
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
end