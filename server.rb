require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'sidekiq'
require_relative './lib/data_import'
require_relative './workers/import_worker'

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0'}
end

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

post '/import' do
  ImportWorker.perform_async(request.body.read)
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)