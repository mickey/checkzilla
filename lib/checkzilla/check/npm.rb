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
        raise "npm: directory doesn't exist" unless File.exists?(@path)
        raw_result = `cd #{@path}; npm outdated --silent`
        raw_result.split("\n").each do |outdated_package|
          outdated_hash = outdated_package.match /^(.+)@(.+)\s.+\s.+=(.+)$/
          @results[outdated_hash[1]] = [outdated_hash[3], outdated_hash[2]]
        end
      end
    end
  end
end