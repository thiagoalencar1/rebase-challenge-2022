require 'pg'

conn = PG.connect(dbname: "postgres", host: '172.17.0.2', port: 5432, user: 'postgres', password: 'pass')

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
    token_exame_result varchar(100),
    exame_date varchar(100),
    exame_type_limit varchar(100),
    exame_result varchar(100)
  );")