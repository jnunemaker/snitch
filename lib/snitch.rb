%w[uri yaml rubygems active_support].each { |x| require x }

require 'snitch/config'
require 'snitch/patches/hash'
require 'snitch/service'
require 'snitch/services/echo'
require 'snitch/services/campfire'
require 'snitch/services/email'
require 'snitch/services/twitter'
require 'snitch/message'
require 'snitch/revisions/subversion'
require 'snitch/revisions/git'
require 'snitch/version'

class Snitch
  attr_reader :services, :config

  class ConfigFileLoadError < StandardError; end

  def initialize(repository, revision, options)
    config_file = options[:config_file]
    Config.config_file_path = config_file unless config_file.nil?
    @config = Config::load
    @revision = 
      case options[:scm] 
      when :git
        Revisions::Git.new(repository, revision)
      when :subversion
        Revisions::Subversion.new(repository, revision, @config[:svnlook])
      else
        raise "Unrecognized scm: #{options[:scm].inspect}"
      end

    @services = []
    @config[:services].each { |s, attrs| use(s, attrs) }
    if @services.empty?
      use('echo', :message_length => :long)
    end
  end

  def commit_message(which = :long)
    @revision.to_s(which)
  end

  def use(s, attrs = {})
    @services << Service.new_from_name(s, attrs)
  end

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
