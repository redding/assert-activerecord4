# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "assert-activerecord4/version"

Gem::Specification.new do |gem|
  gem.name        = "assert-activerecord4"
  gem.version     = AssertActiveRecord4::VERSION
  gem.authors     = ["Kelly Redding", "Collin Redding"]
  gem.email       = ["kelly@kellyredding.com", "collin.redding@me.com"]
  gem.summary     = "AssertActiveRecord adapter for ActiveRecord 4."
  gem.description = "AssertActiveRecord adapter for ActiveRecord 4."
  gem.homepage    = "https://github.com/redding/assert-activerecord4"
  gem.license     = "MIT"

  gem.files         = `git ls-files | grep "^[^.]"`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '> 1.8'

  gem.add_development_dependency("assert", ["~> 2.17.0"])

  gem.add_dependency("activerecord", ["~> 4.0"])

end
