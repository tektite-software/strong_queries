require 'ruby_parser'

module StrongQueries
  class Parser
    def parse_query_param_argument(string)
      ruby_parser_says = RubyParser.new.parse(string)
      handle_ruby_parser_result(ruby_parser_says, string)
    end

    private

    def handle_ruby_parser_result(sexp, original_string)
      case sexp.sexp_type
      when :hash
        Hash[*parse_into_array(sexp, original_string)]
      when :array
        parse_into_array(sexp, original_string)
      when :true
        true
      when :false
        false
      when nil
        nil
      when :nil
        nil
      when :lit
        sexp.value
      when :str
        if sexp.value.match?(/^[a-z0-9_]+$/)
          sexp.value.to_sym
        else
          sexp.value
        end
      when :call
        if original_string.include? ' '
          original_string
        else
          value = sexp.values[1]
          if value.match?(/^[a-z0-9_]+$/)
            value.to_sym
          else
            value.to_s
          end
        end
      end
    end

    def parse_into_array(sexp, original_string)
      result = []
      sexp.each_sexp do |child_sexp|
        result << handle_ruby_parser_result(child_sexp, original_string)
      end
      result
    end
  end
end
