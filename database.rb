require 'rubygems'
require 'bundler'
Bundler.require

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'mysql://root:Root@1234@localhost/openlibrary_dev')

Dir["./models/*.rb"].each { |model| require model }
DataMapper.finalize
