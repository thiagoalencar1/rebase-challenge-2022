require 'pg'
require 'csv'

DATABASE = PG.connect(dbname: 'postgres', host: 'database',  user: 'postgres', password: 'pass')

class DbManager
  def self.create
    DATABASE.exec("
      CREATE TABLE IF NOT EXISTS exams_results (
        id SERIAL PRIMARY KEY, cpf varchar(20), name varchar(450),
        email varchar(100), birthdate varchar(100), address varchar(100),
        city varchar(100), state varchar(100), crm varchar(100), crm_state varchar(100),
        doctor_name varchar(100), doctor_email varchar(100), token_exam_result varchar(100),
        exam_date varchar(100), exam_type varchar(100), exam_type_limit varchar(100), exam_result varchar(100)
      );")
  end

  def self.drop
    DATABASE.exec("DROP TABLE IF EXISTS exams_results")
  end

  def self.reset
    self.drop
    self.create
  end

  def self.import(table)
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
end