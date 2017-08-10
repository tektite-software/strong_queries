require 'ruby_parser'
require 'byebug'

module StrongQueries
  class Parser
    def parse_query_param_argument(string)
      ruby_parser_says = RubyParser.new.parse(string)
      handle_ruby_parser_result(ruby_parser_says, string)
    end

    private

    def handle_ruby_parser_result(exp, original_string)
      case exp.head
      when :hash
        Hash[*parse_into_array(exp.value, original_string)]
      when :array
        parse_into_array(exp.values, original_string)
      when :true
        true
      when :false
        false
      when nil
        nil
      when :lit
        exp.value
      when :str
        if exp.value =~ /^[a-z_]*$/
          exp.value.to_sym
        else
          exp.value
        end
      when :call
        original_string
      end
    end

    def parse_into_array(exp, original_string)
      result = []
      exp.map do |child_exp|
        result << handle_ruby_parser_result(child_exp, original_string)
      end
      result
    end
  end
end
