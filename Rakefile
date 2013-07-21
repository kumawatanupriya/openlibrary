require 'rubygems'
require 'rspec/core/rake_task'
require './database'

namespace :db do
  desc 'Run pending migration'
  task :migrate do
    DataMapper.auto_upgrade!
  end
end

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end
