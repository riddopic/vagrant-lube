
require File.expand_path('../lib/vagrant/lube/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'vagrant-lube'
  gem.version = Vagrant::Lube::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.has_rdoc = false
  gem.extra_rdoc_files = [ 'README.md', 'LICENSE' ]
  gem.summary = 'Various Vagrant helpers.'
  gem.description = gem.summary
  gem.author = 'Stefano Harding'
  gem.email = 'riddopic@gmail.com'
  gem.homepage = 'http://github.com/riddopic/vagrant-lube'
  
  gem.add_dependency 'vagrant'
  gem.add_development_dependency 'sdoc'
  gem.add_development_dependency 'rspec'
  # gem.add_development_dependency 'mocha'
  # gem.add_development_dependency 'minitest', '~> 2.12.0'
  
  gem.files = `git ls-files`.split("\n")
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ['lib']
end
