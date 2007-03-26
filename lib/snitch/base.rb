module Snitch
  class Base
    attr_reader :services, :config
    
    # Creates a new instance of snitch from a repository path and a revision.
    #
    #   Snitch::Base.new('/var/www/apps/myapp/repos', 102)
    #
    # You must have a config file in order for this to work. You can optionally pass in the path to the config file. The default config_file is /home/deploy/.snitch
    #
    #   Snitch::Base.new('/var/www/apps/myapp/repos', 102, '/some/other/path/to/config')
    def initialize(repository, revision, config_file='/home/deploy/.snitch')
      Config.config_file_path = config_file unless config_file.nil?
      @config                 = Config::load
      @svnlook_bin            = SvnLook.new(repository, revision, @config[:svnlook])
      @services               = []
      @config[:services].each { |s, attrs| use(s, attrs) }
    end
    
    # Obtains the commit message from the svnlook class. Takes either <tt>:long</tt> or <tt>:short</tt> as optional parameter. 
    #   * <tt>:long</tt> is the full commit message along with a list of all changed files. 
    #   * <tt>:short</tt> is a truncated version of the commit message that is less than 140 characters for twitter.
    def commit_message(which=:long)
      @svnlook_bin.to_s(which)
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
      long  = commit_message(:long)
      short = commit_message(:short)
      @services.each do |s|
        s.tattle(s.class.message_length == :long ? long : short)
      end
    end
  end
end