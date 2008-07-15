module Snitch
  # This is a module for outputting snitch messages
  # it is included in the SvnLook and GitCommit classes.
  # It requires the class to support the following methods:
  #  project, revision, author, message, affected (a list of files affected)
  module Message
    # Outputs a commit in a pretty format for snitch services
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

  end
end
