require 'sidekiq'
require './lib/data_import'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/'}
end

class ImportWorker
  include Sidekiq::Worker

  def perform(data)
    clinical_exams = CSV.read(data, col_sep: ';', headers: true)
    data_import(clinical_exams)
  end
end
