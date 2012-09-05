# require everything the Gemfile dictates for test
require 'rubygems'
require 'bundler'
Bundler.require(:default, :development, :test)

# add updates lib to $LOAD_PATH
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

# require minitest stuff
$TESTING = true
require 'minitest/unit'
require 'minitest/spec'
require 'test/unit'

require 'updates'

# load all other test helpers
Dir[File.expand_path("../test_helpers/*.rb", __FILE__)].each { |f| require f }