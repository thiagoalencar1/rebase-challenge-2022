require_relative './db_connect'

class ClinicalExams

  def self.find_by_token(token)
    results = DATABASE.exec_params("SELECT * FROM exams_results WHERE token_exam_result = '#{token}'")
    exams = []
    results.each do |result|
      exams << result
    end
  end
end