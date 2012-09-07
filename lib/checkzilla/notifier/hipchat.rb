require 'hipchat'

module CheckZilla
  module Notifier
    class Hipchat

      attr_accessor :api_token
      attr_accessor :room
      attr_accessor :username

      def initialize &block
        instance_eval(&block) if block_given?
        self
      end

      def perform! checkers
        client = HipChat::Client.new(@api_token)
        notify_users = false

        checkers.each do |checker|
          checker_name = checker.class.name.split("::").last
          title = "#{checker_name} Updates:"

          body = []
          checker.results.each do |name, versions|
            local_version = versions[0]
            newer_version = versions[1]
            body << "#{name} (#{local_version} -> #{newer_version})"
          end
          client[@room].send(@username, "#{title} #{body.join(', ')}", :notify => true, :color => 'red')
        end
      end
    end
  end
end