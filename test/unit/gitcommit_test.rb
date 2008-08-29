require File.dirname(__FILE__) + '/../test_helper'

class GitCommitTest < Test::Unit::TestCase
  def setup
    # Creates a test git repo locally and makes a test commit to it
    `mkdir ./test-git.git && cd ./test-git.git && git init && touch test && git add test && git commit -m 'Initial git import.'`
    @gitcommit = Snitch::Revisions::Git.new('./test-git.git')
  end
  
  test 'should have a description' do
    assert_match /^Unnamed repository/, @gitcommit.project
  end

  test 'should have diffs' do
    assert @gitcommit.diffs
  end

  test 'should have a message' do
    assert_equal ' - Initial git import.', @gitcommit.message
  end
  
  test 'should have a commit' do
    assert !@gitcommit.repository.commits.empty?
  end
  
  test 'should have a nice short revision' do
    assert_equal 7, @gitcommit.revision.length, "Git revision number wrong size.  Was #{@gitcommit.revision}"
  end
  
  def teardown
    `rm -rf ./test-git.git`
  end
end
