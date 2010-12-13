# -*- encoding: utf-8 -*-
require 'rubygems' unless Object.const_defined?(:Gem)
require File.dirname(__FILE__) + "/lib/ripl/johnson/version"
 
Gem::Specification.new do |s|
  s.name        = "ripl-johnson"
  s.version     = Ripl::Johnson::VERSION
  s.authors     = ["Gabriel Horner"]
  s.email       = "gabriel.horner@gmail.com"
  s.homepage    = "http://github.com/cldwalker/ripl-johnson"
  s.summary = "A javascript shell using johnson (mozilla's tracemonkey)"
  s.description =  "A javscript shell based on johnson a.k.a mozilla's tracemonkey. Since this uses ripl, it comes with most irb functionality: autocompletion (very basic currently), history (~/.johnson_history) and multi-line support."
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = 'tagaholic'
  s.executables = ['ripl-johnson']
  s.add_dependency 'ripl', '>= 0.2.8'
  s.add_dependency 'johnson', '>= 2.0.0.pre3'
  s.files = Dir.glob(%w[{lib,test}/**/*.rb bin/* [A-Z]*.{txt,rdoc} ext/**/*.{rb,c} **/deps.rip]) + %w{Rakefile .gemspec}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.license = 'MIT'
end
