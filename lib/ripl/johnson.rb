require 'johnson/cli'
require 'ripl'
require 'ripl/johnson/version'
require 'ripl/johnson/completion'

module Ripl::Johnson
  def before_loop
    super
    Ripl::Johnson.runtime.evaluate(Johnson::CLI::JS)
  end

  def loop_eval(expression)
    Ripl::Johnson.runtime.evaluate(expression)
  end

  def self.runtime
    @runtime ||= ::Johnson::Runtime.new
  end

  module Runner
    def load(file)
      Ripl::Johnson.runtime.load(File.expand_path(file))
    end
  end
end

Ripl::Shell.send :include, Ripl::Johnson
Ripl::Runner.extend Ripl::Johnson::Runner

# Needs to wrap Ripl::Johnson#loop_eval
require 'ripl/johnson/multi_line'
