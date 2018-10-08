module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods
  end

  module ClassMethods
    attr_reader :check_list
    def validate(attr, type, options = {})
      @check_list ||= []
      @check_list << {attr_name: attr, type: type, options: options}
    end
  end

  module InstanceMethods



    def validate!
      self.class.check_list.each do |check|
        attr = instance_variable_get "@#{check[:attr_name]}" if check[:attr_name].is_a? Symbol
        format = check[:options][:format]
        class_type = check[:options][:class]
        case check[:type]
        when :presence
          if attr.is_a? String
            raise "Attr is empty" if attr.empty?
          else
            raise "Attr is empty" if attr.nil?
          end
        when :format
          raise "Wrong format!" if attr !~ format
        when :type
          raise "Wrong class exception" unless check[:attr_name].instance_of? class_type
        end
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

  end
end
