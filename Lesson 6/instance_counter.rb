module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods
  end

  module ClassMethods

    def instances
      @inst
    end

    def increase_instances
      @inst ||= 0
      @inst += 1
    end
  end

  module InstanceMethods

    def initialize(*args)
      super(*args)
      register_instance
    end

    private

    def register_instance
      self.class.increase_instances
    end
  end
end
