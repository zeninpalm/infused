require "bundler"
Bundler.setup

require "rake"
require "rspec/core/rake_task"

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "infused/version"

task :gem => :build
task :build do
  system "gem build infused.gemspec"
end

task :install => :build do
  system "sudo gem install Infused-#{Infused::VERSION}.gem"
end

task :release => :build do
  system "git tag -a v#{Infused::VERSION} -m 'Tagging #{Infused::VERSION}'"
  system "git push --tags"
  system "gem push Infused-#{Infused::VERSION}.gem"
  system "rm Infused-#{Infused::VERSION}.gem"
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
