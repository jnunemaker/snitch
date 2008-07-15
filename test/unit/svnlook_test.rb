require File.dirname(__FILE__) + '/../test_helper'

# TODO: move this test to remote folder

class SvnlookTest < Test::Unit::TestCase
  def setup
    @svnlook = Snitch::SvnLook.new(CONFIG[:sshfs_repo], 100, '/usr/local/bin/svnlook')
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
  
  test 'should be able to build short message' do
    cmt_msg = "[conductor] Revision 100 Committed by deploy: - Drop additions "
    assert_equal cmt_msg, @svnlook.to_s(:short)
  end
  
  test 'should be able to find author' do
    assert_equal 'deploy', @svnlook.author
  end
  
  test 'should be able to find project' do
    assert_equal 'conductor', @svnlook.project
  end
end
