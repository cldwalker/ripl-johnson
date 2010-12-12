require 'bond'
module Ripl::Johnson::Completion
  def before_loop
    super
    Ripl::Johnson::Completion.start
  end 

  # From https://developer.mozilla.org/en/JavaScript/Reference

  RESERVED_WORDS = %w{break case catch continue default delete do else
    finally for function if in instanceof new return switch this throw
    try typeof var void while with debugger true false null}

  OBJECTS = %w{Boolean Number String Array Object Function RegExp Date
    Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
    decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite
    isNaN parseFloat parseInt Infinity Math NaN undefined}

  def self.start
    Bond.start(:default_mission=>lambda {|e| Ripl::Johnson::Completion.default_action })
  end

  def self.default_action
    RESERVED_WORDS + OBJECTS + locals
  end

  def self.locals
    Ripl::Johnson.runtime.evaluate(
      "(function() { var arr = []; for(var e in this) { arr.push(e) }; return arr })();"
    ).to_a
  end
end

Ripl::Shell.send  :include, Ripl::Johnson::Completion
