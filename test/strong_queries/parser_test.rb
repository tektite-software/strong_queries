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

    it 'can parse arrays with brackets with and without quotes' do
      query1 = 'test=[one,two,three]'
      query2 = 'test=["one", "two", "three"]'
      rack_parsed_query1 = Rack::Utils.parse_nested_query(query1)
      rack_parsed_query2 = Rack::Utils.parse_nested_query(query2)
      params1 = ActionController::Parameters.new(rack_parsed_query1)
      params2 = ActionController::Parameters.new(rack_parsed_query2)
      query_params1 = params1.permit_query_params(:test)
      query_params2 = params2.permit_query_params(:test)

      query_params1.must_equal({test: [:one, :two, :three]})
      query_params2.must_equal({test: [:one, :two, :three]})
    end

    it 'can parse a nested hash' do
      query = 'filter[where][user_id]=2'
      rack_parsed_query = Rack::Utils.parse_nested_query(query)
      params = ActionController::Parameters.new(rack_parsed_query)
      query_params = params.permit_query_params(filter: { where: [:user_id] } )

      query_params.must_equal({ filter: { where: { user_id: 2 } } } )
    end

    it 'does not allow unpermitted params' do
      query = 'filter[order_by]=created_at&filter[pluck]=password_hash'
      rack_parsed_query = Rack::Utils.parse_nested_query(query)
      params = ActionController::Parameters.new(rack_parsed_query)
      query_params = params.permit_query_params(filter: [:order_by] )
      
      query_params.must_equal({ filter: { order_by: :created_at } } )
    end
  end
end
