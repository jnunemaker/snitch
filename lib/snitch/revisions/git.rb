class Snitch
  module Revisions
    class Git
      include Message
      gem 'mojombo-grit'
      require 'mojombo-grit'
    
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
    
      def diffs
        @diffs ||= @commit.diffs.map(&:diff).join("\n\n")
      end

      def affected
        @affected ||= ' - ' + @commit.diffs.map(&:b_path).join("\n - ")
      end
    end
  end
end