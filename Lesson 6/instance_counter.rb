module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods
  end

  module ClassMethods
    attr_accessor :inst

    def instances
      self.inst
    end

    def increase_instances
      self.inst ||= 0
      self.inst += 1
    end
  end

  module InstanceMethods

    def initialize(*args)
      super
      register_instance
    end

    private

    def register_instance
      self.class.increase_instances
    end
  end
end
