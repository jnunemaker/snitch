require File.dirname(__FILE__) + '/../test_helper'

class BaseTest < Test::Unit::TestCase
  def setup
    repo, checkout = create_subversion_repository_and_checkout
    config_file = File.join(File.dirname(File.expand_path(__FILE__)), 'snitch_config')
    @snitch = Snitch.new(repo, 1, :scm => :subversion, :config_file => config_file)
  end
    
  test 'should add services from config file' do
    assert_equal 3, @snitch.services.size    
  end
  
  # Remote test, uncomment to run
  # TODO: move these to remote folder so that remote and not are seperate
  # test 'should be able to tattle to each service that is being used' do
  #   puts 'Be sure to check the live services in the config file'
  #   @snitch.tattle
  # end
end