require File.dirname(__FILE__) + '/../../test_helper'

class EchoTest < Test::Unit::TestCase
  def setup    
    @service = Snitch::Services::Echo.new({})
  end
  
  test 'should work' do
    @service.tattle('testing')
  end
end