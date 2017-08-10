require 'test_helper'

describe StrongQueries::Parser do
  describe 'parse_query_param_argument' do
    it 'can parse a simple string argument manually entered' do
      query = 'test=hello'
      rack_parsed_query = Rack::Utils.parse_nested_query(query)
      params = ActionController::Parameters.new(rack_parsed_query)
      query_params = params.permit_query_params(:test)

      query_params.must_equal({test: :hello})
    end

    it 'does not make into a symbol strongs with spaces or special chars' do
      query = 'test=hello dolly&test2=abc123&test3=hey_there!'
      rack_parsed_query = Rack::Utils.parse_nested_query(query)
      params = ActionController::Parameters.new(rack_parsed_query)
      query_params = params.permit_query_params(:test, :test2, :test3)

      query_params.must_equal({test: 'hello dolly', test2: :abc123, test3: 'hey_there!'})
    end

    it 'can parse integer literals' do
      query = 'test=123'
      rack_parsed_query = Rack::Utils.parse_nested_query(query)
      params = ActionController::Parameters.new(rack_parsed_query)
      query_params = params.permit_query_params(:test)

      query_params.must_equal({test: 123})
    end

    it 'can parse decimal literals' do
      query = 'test=123.00'
      rack_parsed_query = Rack::Utils.parse_nested_query(query)
      params = ActionController::Parameters.new(rack_parsed_query)
      query_params = params.permit_query_params(:test)

      query_params.must_equal({test: 123.00})
    end

    it 'can parse symbols' do
      query = 'test=:symbol'
      rack_parsed_query = Rack::Utils.parse_nested_query(query)
      params = ActionController::Parameters.new(rack_parsed_query)
      query_params = params.permit_query_params(:test)

      query_params.must_equal({test: :symbol})
    end

    it 'can parse arrays with brackets' do
      query = 'test=[one,two,three]'
      rack_parsed_query = Rack::Utils.parse_nested_query(query)
      params = ActionController::Parameters.new(rack_parsed_query)
      query_params = params.permit_query_params(:test)

      query_params.must_equal({test: ['one', 'two', 'three']})
    end
  end
end
