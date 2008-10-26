require File.dirname(__FILE__) + '/../test_helper'

class ServiceTest < Test::Unit::TestCase
  def setup
    @s = Snitch::Service.new(:login => 'john', :password => 'secret')
  end
  
  test 'should have attributes' do
    assert_equal('john', @s.attributes[:login])
    assert_equal('secret', @s.attributes[:password])
  end
  
  test 'should be able to access keys in the attributes hash like reader methods' do
    assert_equal 'john', @s.login
    assert_equal 'secret', @s.password
  end
  
  test 'should be able to create new instance from name' do
    assert_kind_of Snitch::Services::Echo, Snitch::Service.new_from_name(:echo, {})
    assert_kind_of Snitch::Services::Twitter, Snitch::Service.new_from_name(:twitter, {})
    assert_kind_of Snitch::Services::Campfire, Snitch::Service.new_from_name(:campfire, {})
    assert_kind_of Snitch::Services::Email, Snitch::Service.new_from_name(:email, {})
  end
end