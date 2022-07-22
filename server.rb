require 'sinatra'
require 'rack/handler/puma'
require 'sidekiq'
require_relative './lib/db_manager'
require_relative './lib/clinical_exams'
require_relative './workers/import_worker'

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0'}
end

get '/tests' do
  ClinicalExams.all_exams
end

get '/tests/:token' do
  ClinicalExams.show_exam(params["token"]).to_json
end

post '/import' do
  ImportWorker.perform_async(request.body.read)
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)