module CheckZilla
  class Model

    attr_reader :checkers, :notifiers

    def initialize(title = "Report", &block)
      @title = title
      @checkers = []
      @notifiers = []

      instance_eval(&block) if block_given?

      @checkers.each do |checker|
        checker.perform!
      end

      @notifiers.each do |notifier|
        notifier.perform! @checkers
      end
    end

    def check_updates klass, &block
      @checkers << CheckZilla::Check.const_get(camelize(klass.to_s)).new(&block)
    end

    def notify_by klass, &block
      @notifiers << CheckZilla::Notifier.const_get(camelize(klass.to_s)).new(&block)
    end

    private
      def camelize(term)
        term.split(/[^a-z0-9]/i).map{|w| w.capitalize}.join
      end
  end
end