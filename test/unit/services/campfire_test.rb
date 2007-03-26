require File.dirname(__FILE__) + '/../../test_helper'

class CampfireTest < Test::Unit::TestCase
  def setup    
    @config = CONFIG[:services][:campfire]
    @service = Snitch::Services::Campfire.new(@config)
  end
  
  test 'should have attributes' do
    assert_equal @config, @service.attributes
  end
  
  test 'should have a class instance attribute for the message length' do
    assert_equal :long, Snitch::Services::Campfire.message_length
  end
  
  test 'should connect to campfire room' do
    assert_kind_of Tinder::Room, @service.connection
  end
end