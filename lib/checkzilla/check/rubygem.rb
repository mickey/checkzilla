require 'json'
require 'net/http'
require 'bundler'

module CheckZilla
  module Check
    # Try to determine your gems dependencies and which are not up to date

    # If a path is defined and a Gemfile.lock exists in the repository
    # it will parse it via bundler

    # Otherwise it will parse the output of the `gem list` command (ideal for system wide ruby)

    # Finally it's matching your gem version against the last version in the rubygem api
    # to determine what is up-to-date
    class Rubygem

      attr_accessor :path
      attr_accessor :results

      def initialize &block
        @results = {}
        instance_eval(&block) if block_given?
        self
      end

      def perform!
        dependencies = @path && gemfilelock_exists? ? deps_from_gemfilelock : deps_from_gem_list
        dependencies.each do |gem_name, gem_version|
          http = Net::HTTP.start("rubygems.org", 443,
  use_ssl: true)
          rubygems_response = http.get("/api/v1/gems/#{gem_name}.json")
          if rubygems_response.code.to_i >= 400
            puts "#{rubygems_response.code} on rubygems.org for #{gem_name}: #{rubygems_response.body}"
            next
          end
          newer_version = JSON.parse(rubygems_response.body)['version']
          @results[gem_name] = [gem_version, newer_version] if gem_version != newer_version
        end
      end

      private

        def deps_from_gem_list
          gems = `gem list`.split("\n")
          gems.inject({}) do |list, gem|
            gem_name = gem.split(' ')[0]
            gem_versions = gem.match(/^.+ (\(.+\))$/)[1][1..-2].split(', ')
            list[gem_name] = gem_versions[0]
            list
          end
        end

        def deps_from_gemfilelock
          list = {}
          specs = Bundler::LockfileParser.new(Bundler.read_file(File.join(@path, "Gemfile.lock"))).specs
          specs.each do |gem|
            list[gem.name] = gem.version.to_s
          end
          list
        end

        def gemfilelock_exists?
          File.exists?(File.join(@path, "Gemfile.lock"))
        end
    end
  end
end
