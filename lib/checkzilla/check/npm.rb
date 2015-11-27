
module CheckZilla
  module Check
    class Npm

      attr_accessor :results
      attr_accessor :path

      def initialize &block
        @results = {}
        instance_eval(&block) if block_given?
        raise "npm: path required" if !@path
        self
      end

      def perform!
        raise "npm: directory doesn't exist: %s" % @path unless File.exists?(@path)
        raw_result = `cd #{@path}; npm outdated --silent`
        raw_result.split("\n").each do |outdated_package|
          puts "outdated: %s" % outdated_package
          outdated_hash = outdated_package.split(/\s+/)
          next if outdated_hash[0] == "Package"
          @results[outdated_hash[0]] = [outdated_hash[1], outdated_hash[3]]
        end
      end
    end
  end
end
