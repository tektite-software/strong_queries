require 'test_helper'

describe ActionController::Parameters do
  it 'adds +permit_query_params+ to ActionController::Parameters' do
    params = ActionController::Parameters.new(test_param: 'hello')
    params.must_respond_to :permit_query_params
  end
end
