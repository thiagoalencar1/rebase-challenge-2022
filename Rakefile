require './lib/db_manager'

namespace :db do
  task :prepare do
    DbManager.reset 
  end

  task :seed do
    table = CSV.read('data.csv', col_sep: ';', headers: true)
    DbManager.import(table)
  end
end