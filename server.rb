require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative './lib/data_import'

table = CSV.read('data.csv', col_sep: ';', headers: true)
data_import(table)

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

get '/files' do
  list = Dir.glob("./*.*").map{|f| f.split('/').last}
  # render list here
end

get '/import' do
  "
  <form action='http://localhost:3000/results' method='POST' enctype='multipart/form-data'>
    <input type='file' name='file'>
    <input type='submit' value='Carregar Exames'>
  </form>
  "
end

post '/import' do
  begin
    path = "import/#{File.basename(request.body.to_path)}"
    ImportJob.perform_async(path)
    201
  rescue
    500
  end
  data = request.body.read
end


Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)