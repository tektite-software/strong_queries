require 'test_helper'

describe PostsController do
  it 'adds +permit_query_params+ to app controllers' do
    get posts_url, params: { test_param: 'hello' }
    @controller.params.must_respond_to :permit_query_params
  end
end
