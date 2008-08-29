class Snitch
  class Config
    @@snitch_config_path = '/home/deploy/.snitch'
    
    class << self
      def config_file_path
        @@snitch_config_path
      end
      
      def config_file_path=(new_path)
        @@snitch_config_path = new_path
      end
      
      # Loads the config file. If the file does not exist, it creates it and fills in a blank template that only needs settings.
      def load
        begin
          config = YAML::load(open(@@snitch_config_path)).symbolize_keys!
        rescue
          create
          raise ConfigFileLoadError, "The config file was missing or could not be loaded because of a parse error. It should be here: #{@@snitch_config_path}. Fill it out and try again."
        end
      end
      
      # Creates a config file based on a template.
      def create
        snitch_config_tpl = <<EOF
# what is the location of svnlook (you can find this on *nix boxes by typing `which svnlook`)
svnlook: /usr/bin/svnlook

# what services would you like to send commit messages to?
services:
  :campfire:
    :subdomain: 
    :login: 
    :password: 
    :room: Development
  :twitter:
    :login: 
    :password: 
  :email:
   # You mail server settings:
    :host:
    :server: localhost
    :port: 25
   # Your login creds:
    :login:
    :password:
    :method: :login
   # Our email addresses:
    :from: Snitch <root@localhost>
    :to:
EOF
        File.open(config_file_path, 'w') { |f| f.write snitch_config_tpl } unless File.exists?(config_file_path)
      end
    end
  end
end
