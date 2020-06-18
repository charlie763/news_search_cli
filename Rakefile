require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'pry'
require_relative "./lib/news_search_cli.rb"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
	Pry.start
end
