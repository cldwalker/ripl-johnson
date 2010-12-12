module Ripl::Johnson::MultiLine
  def before_loop
    super
    @buffer = @unterminated_string = nil
  end

  def prompt
    @buffer ? config[:johnson_multi_line_prompt] : super
  end

  def loop_once
    catch(:multiline) do
      super
      @buffer = nil
    end
  end

  def print_eval_error(e)
    if e.is_a?(::Johnson::Error) && e.original_exception.to_s[/^SyntaxError/]
      @unterminated_string = e.to_s[/unterminated string literal/]
      @buffer ||= []
      @buffer << @input
      throw :multiline
    else
      super
    end
  end

  def loop_eval(input)
    if @buffer
      join = @unterminated_string ? "" : "\n"
      super @buffer* join + join + input
    else
      super input
    end
  end

  def handle_interrupt
    @buffer = @unterminated_string = nil
    super
  end
end

Ripl::Shell.send :include, Ripl::Johnson::MultiLine
Ripl.config[:johnson_multi_line_prompt] ||= '   > '
