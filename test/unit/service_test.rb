require File.dirname(__FILE__) + '/../test_helper'

class ServiceTest < Test::Unit::TestCase
  def setup
    @s = Snitch::Service.new(:login => 'john', :password => 'secret')
  end
  
  test 'should have attributes' do
    assert_equal({:login => 'john', :password => 'secret'}, @s.attributes)
  end
  
  test 'should be able to access keys in the attributes hash like reader methods' do
    assert_equal 'john', @s.login
    assert_equal 'secret', @s.password
  end
  
  test 'should be able to change key values in the attributes hash like writer methods' do
    @s.login = 'jdog'
    assert_equal 'jdog', @s.login
  end
  
  test 'should be able to set key values in the attributes hash that were not in initialize' do
    @s.fart = 't'
    assert_equal('t', @s.fart)
  end
  
  test 'should be able to create new instance from name' do
    assert_kind_of Snitch::Services::Twitter, Snitch::Service.new_from_name(:twitter, {})
    assert_kind_of Snitch::Services::Campfire, Snitch::Service.new_from_name(:campfire, {})
  end
end