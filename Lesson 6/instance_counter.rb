module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
    @instances = 0

    def instances
      self.instances
    end

    # def increase_instances
    #   self.instances += 1
    # end
  end

  module InstanceMethods

    def initialize(*args)
      super(*args)
      register_instance
    end

    private

    def register_instance
      self.class.instances += 1
    end
  end
end
