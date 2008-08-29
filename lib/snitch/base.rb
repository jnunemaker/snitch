module Snitch
  class Base
    attr_reader :services, :config
    
    # Creates a new snitch repository path and a revision.
    #
    #   Snitch::Base.new('/var/www/apps/myapp/repos', 102, :config_file => '/home/user/.snitch')
    def initialize(repository, revision, options)
      config_file = options[:config_file]
      Config.config_file_path = config_file unless config_file.nil?
      @config                 = Config::load
      @scm = 
        case options[:scm] 
        when :git
          GitCommit.new(repository, revision)
        when :subversion
          SvnLook.new(repository, revision, @config[:svnlook])
        end
        
      @services               = []
      @config[:services].each { |s, attrs| use(s, attrs) }
    end
    
    # Obtains the commit message from the svnlook class. Takes either <tt>:long</tt> or <tt>:short</tt> as optional parameter. 
    #   * <tt>:long</tt> is the full commit message along with a list of all changed files. 
    #   * <tt>:short</tt> is a truncated version of the commit message that is less than 140 characters for twitter.
    def commit_message(which=:long)
      @scm.to_s(which)
    end
    
    # Adds a service to the services array from a string or symbol of the service name and a hash of attributes.
    #
    #   snitch = Snitch::Base.new('/var/www/apps/myapp/repos', 102)
    #   snitch.use(:twitter, {:login => 'jnunemaker', :password => 'secret'})
    def use(s, attrs)
      @services << Service.new_from_name(s, attrs)
    end
    
    # Sends the commit message to all the added services. The following code would tattle the commit message to twitter.
    #
    #   snitch = Snitch::Base.new('/var/www/apps/myapp/repos', 102)
    #   snitch.use(:twitter, {:login => 'jnunemaker', :password => 'secret'})
    #   snitch.tattle
    def tattle
      superlong = commit_message(:superlong)
      long = commit_message(:long)
      short = commit_message(:short)
      @services.each do |s|
        message = 
          case s.message_length.to_s
            when 'superlong'
              superlong
            when 'long'
              long
            else
              short
          end
          
        s.tattle(message)
      end
    end
  end
end
