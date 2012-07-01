#!/usr/bin/env rake
require 'bundler/gem_tasks'


task :rspec do
  require 'rspec'
  Dir.glob("spec/**/*_spec.rb").each { |filename| require File.expand_path filename }
  RSpec::Core::Runner.run []
end

require 'cucumber/rake/task'
default_cucumber_opts = "features --format pretty --tags ~@not-implemented"
Cucumber::Rake::Task.new(:cucumber)      { |t| t.cucumber_opts = default_cucumber_opts + " --tags ~@wip" }
Cucumber::Rake::Task.new('cucumber:wip') { |t| t.cucumber_opts = default_cucumber_opts + " --tags @wip" }

task default: [:rspec, :cucumber]


