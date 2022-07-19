require 'sidekiq'
require './lib/data_import'

class ImportWorker
  include Sidekiq::Worker

  def perform(data)
    clinical_exams = CSV.read(data, col_sep: ';', headers: true)
    data_import(clinical_exams)
  end
end
