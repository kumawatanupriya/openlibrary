require File.expand_path('../../database.rb', __FILE__)
require 'csv'


def read_csv(csv_file)
  tickers = []
  CSV.foreach(csv_file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
    tickers << Hash[row.headers.zip(row.fields)]
  end
  tickers
end

users = read_csv(ARGV[0])

if(ENV['MODEL'] == 'User')
  users.each do |user_params|
    User.create(employee_id: user_params[:employee_id], first_name: user_params[:first_name], last_name: user_params[:last_name])
  end
end

