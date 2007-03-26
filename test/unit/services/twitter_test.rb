require File.dirname(__FILE__) + '/../../test_helper'

class TwitterTest < Test::Unit::TestCase
  def setup    
    @config = CONFIG[:services][:twitter]
    @service = Snitch::Services::Twitter.new(@config)
  end
  
  test 'should have attributes' do
    assert_equal @config, @service.attributes
  end
  
  test 'should have a class instance attribute for the message length' do
    assert_equal :short, Snitch::Services::Twitter.message_length
  end
  
  test 'should connect to campfire room' do
    assert_kind_of Twitter::Base, @service.connection
  end
end