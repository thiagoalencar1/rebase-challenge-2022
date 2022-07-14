require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative 'lib/data_import'

get '/tests' do
  conn = PG.connect(dbname: 'postgres', host: '127.0.0.1', port: 5432,  user: 'postgres', password: 'pass')
  exams = conn.exec("SELECT * FROM exams_results")
  
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
