require File.expand_path('../../database.rb', __FILE__)
require 'csv'


def read_csv(csv_file)
  tickers = []
  CSV.foreach(csv_file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
    tickers << Hash[row.headers.zip(row.fields)]
  end
  tickers
end

users = CSV.read(ARGV[0])

if(ENV['MODEL'] == 'User')
  users[1..-1].each do |user_params|
    User.create(employee_id: user_params[1], first_name: user_params[2], last_name: user_params[3])
  end
end

