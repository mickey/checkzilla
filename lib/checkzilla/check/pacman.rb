require 'json'
require 'net/http'

# requires package-query
module CheckZilla
  module Check
    class Pacman

      attr_accessor :results

      def initialize &block
        @results = {}
        instance_eval(&block) if block_given?
        self
      end

      def perform!
        cmd = ''
        cmd = "sudo pacman -Sy > /dev/null ; package-query -AQu -f '%n %l %V'"
        packages = `#{cmd}`.split("\n")
        
        packages.each do |package|
          package_name, package_current_version, package_db_version = package.split(' ')
          @results[package_name] = [package_current_version, package_db_version]
        end
      end
    end
  end
end