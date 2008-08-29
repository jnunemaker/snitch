require File.dirname(__FILE__) + '/../../test_helper'

# TODO: move this test to remote folder

class SubersionTest < Test::Unit::TestCase
  def setup
    # Creates a test subversion repo locally and makes a test commit to it
    repo, checkout = create_subversion_repository_and_checkout
    @revision = Snitch::Revisions::Subversion.new(repo, 1)
  end
  
  test 'should be able to load repository' do
    @revision
  end
  
  test 'should be able to build long message' do
    cmt_msg = <<EOF
[conductor] Revision 100 Committed by deploy:
 - Drop additions

Changed Files:
 - U   trunk/app/controllers/conductor_controller.rb
 - A   trunk/app/drops/page_drop.rb
 - U   trunk/app/drops/site_drop.rb
 - U   trunk/app/models/page.rb
EOF
    assert_equal cmt_msg, @svnlook.to_s(:long)
  end
#   
#   test 'should be able to build short message' do
#     cmt_msg = "[conductor] Revision 100 Committed by deploy: - Drop additions "
#     assert_equal cmt_msg, @svnlook.to_s(:short)
#   end
#   
#   test 'should be able to find author' do
#     assert_equal 'deploy', @svnlook.author
#   end
  
  # test 'should be able to figure out project name' do
  #   assert_equal 'conductor', @svnlook.project
  # end
  
  def teardown
    `rm -rf ./test-subversion-repository`
    `rm -rf ./test-subversion-checkout`
  end
  
end
