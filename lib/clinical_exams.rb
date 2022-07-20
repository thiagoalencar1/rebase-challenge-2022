require_relative './db_connect'

class ClinicalExams
  def self.all_exams(exams = DATABASE.exec("SELECT * FROM exams_results"))

    column_names = exams.fields

    exams.map do |exam|
      exam.each_with_object({}).with_index do |(cell, acc), idx|
        column = column_names[idx]
        acc[column] = cell[1]
      end
    end.to_json
  end

  def self.show_exam(token)
    header = DATABASE.exec_params("SELECT token_exam_result, exam_date, cpf, name, email, exam_date FROM exams_results WHERE token_exam_result = '#{token}'").to_a
    doctor = DATABASE.exec_params("SELECT doctor_name, doctor_email, crm, crm_state FROM exams_results WHERE token_exam_result = '#{token}'").to_a
    tests = DATABASE.exec_params("SELECT exam_type, exam_type_limit, exam_result FROM exams_results where token_exam_result = '#{token}'").to_a

    details = header.first
    details = details.merge('doctor' => doctor.first)
    details = details.merge('tests' => tests)

    details
  end
end