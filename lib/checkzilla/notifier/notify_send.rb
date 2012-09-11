module CheckZilla
  module Notifier
    class NotifySend

      def initialize &block
        self
      end

      def perform! checkers
        checkers.each do |checker|
          checker_name = checker.class.name.split("::").last
          title = "CheckZilla: #{checker_name}"

          body = []
          checker.results.each do |name, versions|
            local_version = versions[0]
            newer_version = versions[1]
            body << "#{name} (#{local_version} -> #{newer_version})"
          end
          `notify-send -u normal "#{title}" "#{body.join(', ')}"` if body.size > 0
        end
      end
    end
  end
end