require 'pony'

module CheckZilla
  module Notifier
    class Email

      attr_accessor :pony_settings

      def initialize &block
        instance_eval(&block) if block_given?
        self
      end

      def perform! checkers
        body = []
        checkers.each do |checker|
          checker_name = checker.class.name.split("::").last
          title = "#{checker_name} Report"
          body << "#{title}\n#{"="*title.size}"

          checker.results.each do |name, versions|
            local_version = versions[0]
            newer_version = versions[1]
            body << "#{name} from #{local_version} to #{newer_version}"
          end
          body << ["\n\n"]
        end
        binding.pry
        Pony.mail(@pony_settings.merge(:body => body.join("\n")))
      end
    end
  end
end