require 'pg'

conn = PG.connect(dbname: 'postgres', host: '127.0.0.1', port: 5432,  user: 'postgres', password: 'pass')
conn.exec("DROP TABLE IF EXISTS exams_results")

conn.exec("
  CREATE TABLE IF NOT EXISTS exams_results (
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
    token_exam_result varchar(100),
    exam_date varchar(100),
    exam_type varchar(100),
    exam_type_limit varchar(100),
    exam_result varchar(100)
  );")