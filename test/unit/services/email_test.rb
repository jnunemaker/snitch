require File.dirname(__FILE__) + '/../../test_helper'

class EmailTest < Test::Unit::TestCase
  def setup
    @config = CONFIG[:services][:email]
    @service = Snitch::Services::Email.new(@config)
  end
  
  test 'should have attributes' do
    assert_equal @config, @service.attributes
  end
  
  test "should make the email's body the commit message"
  
  test "should set the To field to what's in the config"
  
  test "should set the From field with what's in the config"
  
  test "should connect to the server in the config"
  
  test "should connect on the port in the config"
  
  test "should login using the login and password config options"
  
  test "should use the authentication method from the config"
  
  test "should use the host from the config as the mail server's name"
  
  test "should tattle by sending the email"
  
end
