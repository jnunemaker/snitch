# This file simply includes the gems and snitch files needed.

%w[uri yaml rubygems active_support].each { |x| require x }

require 'snitch/base'
require 'snitch/config'
require 'snitch/exceptions'
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
