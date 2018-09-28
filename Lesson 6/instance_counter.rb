module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods
  end

  module ClassMethods

    attr_reader :instances

    def increase_instances
      @instances ||= 0
      @instances += 1
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
