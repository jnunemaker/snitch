require File.dirname(__FILE__) + '/../../test_helper'

# TODO: move this test to remote folder

class SubversionTest < Test::Unit::TestCase
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
[snitch] Revision 1 Committed by #{current_user}:
 - Initial subversion import.

Changed Files:
 - A   test
EOF
    assert_equal cmt_msg, @revision.to_s(:long)
  end

  test 'should be able to build short message' do
    cmt_msg = "[snitch] Revision 1 Committed by #{current_user}: Initial subversion import. "
    assert_equal cmt_msg, @revision.to_s(:short)
  end

  test 'should be able to find author' do
    assert_equal current_user, @revision.author
  end
  
  test 'should be able to figure out project name' do
    assert_equal 'snitch', @revision.project
  end
  
  def teardown
    `rm -rf ./test-subversion-repository`
    `rm -rf ./test-subversion-checkout`
  end
  
end
