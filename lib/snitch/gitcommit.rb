module Snitch
  # A simple interface class for snitch's services to use.  Requires the mojombo-grit gem
  #   
  #   gitcommit = Snitch::GitCommit.new('/var/www/apps/yourapp.git/', 'a9s8d76f9as8d76f9sa...'
  #   puts gitcommit.author, gitcommit.project # etc, etc, etc.
  #
  class GitCommit
    include Message
    
    attr_reader :repository
    
    def initialize(repository, revision = nil)
      @repository, @revision = Grit::Repo.new(repository), revision
      @commit = revision ? @repository.commit( revision ) : @repository.commits.first
    end
    
    # Only show the first 7 digits of the yucky SHA hash
    def revision
      @commit.id_abbrev 
    end
    
    def author
      @commit.author.to_s
    end
    
    def project
      @repository.description
    end
    
    def message
      " - #{@commit.message}"
    end
    
    def affected
      @affected ||= ' - ' + @commit.diffs.map(&:b_path).join("\n - ")
    end
  end
end
