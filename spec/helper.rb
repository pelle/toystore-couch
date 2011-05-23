$:.unshift(File.expand_path('../../lib', __FILE__))

require 'pathname'
require 'logger'

root_path = Pathname(__FILE__).dirname.join('..').expand_path
lib_path  = root_path.join('lib')
log_path  = root_path.join('log')
log_path.mkpath

require 'rubygems'
require 'bundler'

Bundler.require(:development)

require 'toy/couch'
require 'support/constants'

STORE = CouchRest.database!("http://127.0.0.1:5984/toystore-couch-test")

Logger.new(log_path.join('test.log')).tap do |log|
  LogBuddy.init(:logger => log)
  Toy.logger = log
end

RSpec.configure do |c|
  c.include(Support::Constants)

  c.before(:each) do
    STORE.recreate!
  end
end