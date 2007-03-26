module Snitch
  # This is a wrapper around the svnlook command line utility. I saw someone else using it so I did. I haven't looked around for other options but I will as I'm not a fan of relying on command line stuff. 
  #
  #   svnlook = Snitch::SvnLook.new('/var/www/apps/yourapp/repos/', 101)
  #   puts svnlook.author, svnlook.project # etc, etc, etc.
  # 
  # The svnlook bin file defaults to /usr/bin/svnlook. To override the location of svnlook, just pass in a third parameter to the new method like so:
  #
  #   svnlook = Snitch::SvnLook.new('/var/www/apps/yourapp/repos/', 101, '/usr/local/bin/svnlook')
  class SvnLook
    
    LOG_PREPEND = '\n-{2}'
    
    attr_reader :repository, :revision
    
    def initialize(repository, revision, svn_look_path=nil)
      @repository, @revision, @svnlook = repository, revision, svn_look_path
      @svnlook = svn_look_path || '/usr/bin/svnlook'
    end
    
    # Creates a few helper methods for looking at the subversion commit
    %w[changed date diff log].each { |m| define_method(m) { look m } }
    
    # Does an svn look for the author of the commit. Can't be in the fancy meta programming above because it needs to get a newline chopped off.
    def author
      look(:author).chop
    end
    
    # Returns a best guess of the projects name. Assumes that most will be /some/path/to/cabin/repos/.
    # Using the aforementioned path, this would return cabin as the project name.
    def project
      @project ||= repository.split('/')[-2]
    end
    
    # Returns the message entered with the committed revision
    def message
      @message ||= log.split(%r{#{LOG_PREPEND}}).inject('') { |str, log_item| str << " - #{log_item.gsub(/-/, '').capitalize}"; str }
    end
    
    # Returns the affected files of the committed revision
    def affected
      @affected ||= changed.inject('') { |str, line| str << " - #{line}"; str }
    end
    
    # Outputs the SvnLook in a pretty format for pasting into campfire
    def to_s(which=:long)
      case which.to_s
      when 'long'
        "[#{project}] Revision #{revision} Committed by #{author}:\n#{message}\nChanged Files:\n#{affected}"
      when 'short'
        str = "[#{project}] Revision #{revision} Committed by #{author}:"        
        str += message.size > 137 ? message[0, (140 - str.size)] + '...' : message
        str.gsub("\n", ' ')
      end
    end
    
    private
      # runs an svn look command
      def look(method)
        `#{@svnlook} #{method.to_s} #{repository} -r #{revision}`
      end
  end
end