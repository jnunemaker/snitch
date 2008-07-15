# This file simply includes the gems and snitch files needed.

%w[uri yaml rubygems active_support].each { |x| require x }

require 'snitch/base'
require 'snitch/config'
require 'snitch/exceptions'
require 'snitch/patches/hash'
require 'snitch/patches/tinder'
require 'snitch/service'
require 'snitch/services/campfire'
require 'snitch/services/email'
require 'snitch/services/twitter'
require 'snitch/message'
require 'snitch/svnlook'
require 'snitch/gitcommit'
require 'snitch/version'
