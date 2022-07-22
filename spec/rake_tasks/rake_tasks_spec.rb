
RSpec.describe 'RakeTasks', type: :rake_task do
  before(:each) { DbManager.reset }
  after(:each) { DbManager.drop }

  it '#db:seed' do
    file = CSV.read('./spec/support/test_data.csv', col_sep: ';', headers: true)
    allow(CSV).to receive(:read).and_return(file)
    
    Rake::Task['db:seed'].execute

    expect(DbManager.find_all.count).to eq 7
  end

  it '#db:prepare' do
    Rake::Task['db:prepare'].execute

    expect(DbManager.find_all.count).to eq 0
  end
end