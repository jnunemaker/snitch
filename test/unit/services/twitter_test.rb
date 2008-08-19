require File.dirname(__FILE__) + '/../../test_helper'

class TwitterTest < Test::Unit::TestCase
  def setup    
    @config = CONFIG[:services][:twitter]
    @service = Snitch::Services::Twitter.new(@config)
  end
  
  test 'should have attributes' do
    assert_not_equal({}, @service.attributes)
  end
  
  test 'should default the message length to :short' do
    assert_equal :short, Snitch::Services::Twitter.new.message_length
  end

  test 'should allow overriding of message length' do
    assert_equal :superlong, Snitch::Services::Twitter.new(:message_length => :superlong).message_length
  end
  
  test 'should connect to campfire room' do
    assert_kind_of Twitter::Base, @service.connection
  end
end