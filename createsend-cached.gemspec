# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "createsend_cached/version"

Gem::Specification.new do |s|
  s.name    = 'createsend-cached'
  s.version = CreateSendCached::VERSION
  s.platform = Gem::Platform::RUBY
  if s.respond_to? :required_rubygems_version=
    s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  end

  s.authors     = ['Sean Seefried']
  s.email       = 'sean.seefried@gmail.com'
  s.description =
    'Download and cache results from createsend gem (which interfaces to Campaign Monitor API)'
  s.summary     = s.description
  s.homepage    = 'https://github.com/sseefried/createsend-cached'
  s.license     = 'MIT'

  # Runtime depdendencies
  s.add_dependency 'createsend', '~> 4.0.1'

  # Development dependencies
  s.add_development_dependency 'appraisal', '~> 1.0.0'
  s.add_development_dependency 'rails', '~> 4.1.0'
  s.add_development_dependency 'rspec-rails', '~> 3.0'
  s.add_development_dependency 'sqlite3', '~> 1.0'

  s.files         = `git ls-files`.split($\).reject{|f| f =~ /(\.gemspec|lib\/createsend_cached\-|adapters|generators)/ }
  s.test_files    = s.files.grep(/^spec\//)
  s.require_paths = ['lib']
end

