require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative './lib/data_import'

get '/tests' do
  exams = DATABASE.exec("SELECT * FROM exams_results")
  
  column_names = exams.fields
  
  exams.map do |exam|
    exam.each_with_object({}).with_index do |(cell, acc), idx|
      column = column_names[idx]
      acc[column] = cell[1]
    end
  end.to_json
end

get '/tests/:token' do
  exams = DATABASE.exec_params("SELECT * FROM exams_results WHERE token_exam_result = '#{params[:token]}'")

  column_names = exams.fields
  
  exams.map do |exam|
    exam.each_with_object({}).with_index do |(cell, acc), idx|
      column = column_names[idx]
      acc[column] = cell[1]
    end
  end.to_json

end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)