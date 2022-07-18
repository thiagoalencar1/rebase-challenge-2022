require 'sidekiq'
require './lib/data_import'

class ImportJob
  include Sidekiq::Job

  def perform(path)
    file = open(path, 'r')
    data_import(file)
    File.delete(path)
  end
end
