
require 'rubygems/package_task'
require 'rdoc/task'
require 'rake/clean'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

GEM_NAME = 'vagrant-lube'

spec = eval(File.read('vagrant-lube.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

begin
  require 'sdoc'

  Rake::RDocTask.new do |rdoc|
    rdoc.title = "Various Vagrant helpers Ruby API Documentation"
    rdoc.main = "README.rdoc"
    rdoc.options << '--fmt' << 'shtml'
    rdoc.template = 'direct'
    rdoc.rdoc_files.include("README.rdoc", "LICENSE", "lib/**/*.rb")
    rdoc.rdoc_dir = "rdoc"
  end
rescue LoadError
  puts "sdoc is not available. (sudo) gem install sdoc to generate rdoc documentation."
end

task :default => :test

task :spec => :test

desc "Run all functional specs in this ruby environment"
RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/*_spec.rb'

  t.rspec_opts = [ 
    '--format', 'documentation',
    #  This is only really needed once - we can remove it from all the specs
    #'--require ./spec/spec_helper.rb',
    '--color',
  ]
end

desc "Run the specs through all the supported rubies"
task :rubies do
  system("rvm 1.9.3-p374 do rake test")
end

desc "Set up all ruby environments"
namespace :bootstrap do
  task :all_rubies do
  end
end

CLEAN.include 'pkg'
