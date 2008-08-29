require File.dirname(__FILE__) + '/../../test_helper'

class CampfireTest < Test::Unit::TestCase
  def setup    
    @config = CONFIG[:services][:campfire]
    @service = Snitch::Services::Campfire.new(@config)
  end
    
  test 'should connect to campfire room' do
    assert_kind_of Tinder::Room, @service.connection
  end
end