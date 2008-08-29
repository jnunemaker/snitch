class Snitch
  module Message
    # Outputs a commit in a pretty format for snitch services
    def to_s(which=:long)
      case which.to_s
      when 'superlong'
        "[#{project}] Revision #{revision} Committed by #{author}:\n#{message}\nChanged Files:\n#{diffs}"
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
