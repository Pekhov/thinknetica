module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :check_list

    def validate(attr, type, options = {})
      @check_list ||= []
      @check_list << { attr_name: attr, type: type, options: options }
    end
  end

  module InstanceMethods
    def validate!
      self.class.check_list.each do |check|
        attr = if check[:attr_name].is_a? Symbol
                 instance_variable_get "@#{check[:attr_name]}"
               else
                 check[:attr_name]
               end
        send(check[:type].to_sym, attr, check[:options])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def presence(attr, options = {})
      if attr.is_a? String
        raise "Attr is empty" if attr.empty?
      else
        raise "Attr is empty" if attr.nil?
      end
    end

    def format(attr, options = {})
      raise "Wrong format!" if attr !~ options[:format]
    end

    def type(attr, options = {})
      raise "Wrong class exception" unless attr.instance_of? options[:class]
    end
  end
end
