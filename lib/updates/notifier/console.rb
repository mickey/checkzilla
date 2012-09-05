module Updates
  module Notifier
    class Console
      def initialize &block
      end

      def perform! checkers
        checkers.each do |checker|
          checker_name = checker.class.name.split("::").last
          title = "#{checker_name} Report"
          puts "#{title}\n#{"="*title.size}"

          checker.results.each do |name, versions|
            local_version = versions[0]
            newer_version = versions[1]
            puts "#{name} from #{local_version} to #{newer_version}"
          end
        end
      end
    end
  end
end