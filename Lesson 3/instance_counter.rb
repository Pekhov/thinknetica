module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods
  end

  module ClassMethods
    @@instances = 0

    def instances
      @@instances
    end

    def increase_instances
      @@instances += 1
    end
  end

  module InstanceMethods

    def initialize(*args)
      super(*args)
      register_instance
    end

    protected

    def register_instance
      self.class.increase_instances
    end
  end
end
