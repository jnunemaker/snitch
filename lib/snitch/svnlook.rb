class Snitch
  module Revisions
    class Subversion
      include Message
      LOG_PREPEND = '\n-{2}'
    
      attr_reader :repository, :revision
    
      def initialize(repository, revision, svn_look_path=nil)
        @repository, @revision, @svnlook = repository, revision, svn_look_path
        @svnlook = svn_look_path || '/usr/bin/svnlook'
      end
    
      # Creates a few helper methods for looking at the subversion commit
      %w[changed date diff log].each { |m| define_method(m) { look m } }
    
      def author
        look(:author).chop
      end
    
      # Returns a best guess of the projects name. Assumes that most will be 
      # /some/path/to/cabin/repos/ or /some/path/to/cabin. Will grab the last 
      # two folders in the path and remove any that are equal to "repos".
      def project
        # @project ||= repository.split('/')[-2]
        @project ||= repository.split('/')[-2, 2].detect { |a| a != 'repos' }
      end
    
      def message
        @message ||= log.split(%r{#{LOG_PREPEND}}).inject('') { |str, log_item| str << " - #{log_item.gsub(/-/, '').capitalize}"; str }
      end
    
      def affected
        @affected ||= changed.inject('') { |str, line| str << " - #{line}"; str }
      end
        
      private

      def look(method)
        `#{@svnlook} #{method.to_s} #{repository} -r #{revision}`
      end
    end
  end
end
