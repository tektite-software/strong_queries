require 'test_helper'

describe StrongQueries do
  it 'is a module' do
    StrongQueries.must_be_kind_of Module
  end

  it 'has a semantic version' do
    StrongQueries::VERSION.must_match(/\d*\.\d*\.\d*(\..*)?/)
  end
end
