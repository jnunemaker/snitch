class Snitch
  class Revision
    attr_accessor :repository_path, :revision
    
    def initialize(repository_path, revision)
      self.repository_path, self.revision = repository_path, revision
    end
    
    def self.new_from_name(name, repository_path, revision)
      case name 
      when :git
        Revisions::Git.new(repository_path, revision)
      when :subversion
        Revisions::Subversion.new(repository_path, revision)
      else
        raise "Unrecognized scm: #{name}"
      end
    end
    
  end
end