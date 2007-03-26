require File.dirname(__FILE__) + '/../test_helper'

class BaseTest < Test::Unit::TestCase
  def setup
    @snitch = Snitch::Base.new('/Volumes/ndwebgroup-app.railsmachina.com/var/www/apps/conductor/repos', 100)
  end
    
  test 'should add services from config file' do
    assert_equal 2, @snitch.services.size    
  end
  
  # Remote test, uncomment to run
  # TODO: move these to remote folder so that remote and not are seperate
  # test 'should be able to tattle to each service that is being used' do
  #   puts 'Be sure to check the live services in the config file'
  #   @snitch.tattle
  # end
end