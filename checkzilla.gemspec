# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "checkzilla"
  s.version     = "0.1.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael Bensoussan"]
  s.email       = ["mbensoussan.is@gmail.com"]
  s.homepage    = "http://github.com/mickey/checkzilla"
  s.summary     = "CLI allowing to check and be notified of outdated software"
  s.description = "CheckZilla is a command line tool allowing you to check and be notified of outdated software."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "checkzilla"

  s.add_dependency('clamp')
  s.add_dependency('hipchat')
  s.add_dependency('clamp', '>= 0.3.0')
  s.add_dependency('pony')

  libglob = File::join(File::dirname(__FILE__), "lib/**/*")
  binglob = File::join(File::dirname(__FILE__), "bin/checkzilla*")

  s.files        = Dir[libglob] + Dir[binglob]
  s.executables  = ['checkzilla']
  s.require_path = 'lib'
end