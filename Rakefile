#!/usr/bin/env rake
require 'bundler/setup'


desc 'Run specs'
task :spec do
  sh 'rspec'
end

desc 'Run non-work-in-progress cukes'
task :cuke do
  sh 'cucumber --tag ~@wip'
end

namespace :cuke do
  desc 'Run work-in-progress cukes'
  task :wip do
    sh 'cucumber --tag @wip'
  end
end

task default: [:spec, :cuke]
