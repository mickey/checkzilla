require 'twitter'

module CheckZilla
  module Notifier
    class Twitter

      attr_accessor :consumer_key
      attr_accessor :consumer_secret
      attr_accessor :oauth_token
      attr_accessor :oauth_token_secret

      # TODO: add a `template` accessor so you can pimp your tweet (with mentions by exemple)
      def initialize &block
        instance_eval(&block) if block_given?
        [:consumer_secret, :consumer_key, :oauth_token, :oauth_token_secret].each do |required|
          if self.send(required).nil? || self.send(required).strip.empty?
            raise "Notifier Twitter: you need to provide a #{required}"
          end
        end
        self
      end

      def perform! checkers
        init_twitter!
        checkers.each do |checker|
          checker_name = checker.class.name.split("::").last
          title = "#{checker_name} Updates:"

          body = []
          checker.results.each do |name, versions|
            local_version = versions[0]
            newer_version = versions[1]
            body << "#{name}(#{local_version}->#{newer_version})"
          end
          ::Twitter.update("(checkzilla) #{title} #{body.join(', ')}")
        end
      end

      private
        def init_twitter!
          ::Twitter.configure do |config|
            config.consumer_key = consumer_key
            config.consumer_secret = consumer_secret
            config.oauth_token = oauth_token
            config.oauth_token_secret = oauth_token_secret
          end
        end
    end
  end
end