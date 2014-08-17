#!/usr/bin/env rake
require 'bundler/gem_tasks'


desc 'Run specs'
task :rspec do
  sh 'rspec'
end

desc 'Run non-work-in-progress cukes'
task :cucumber do
  sh 'cucumber --tag ~@wip'
end

namespace :cucumber do
  desc 'Run work-in-progress cukes'
  task :wip do
    sh 'cucumber --tag @wip'
  end
end

task default: [:rspec, :cucumber]
