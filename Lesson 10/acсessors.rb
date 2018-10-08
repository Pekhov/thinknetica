module Acсessors

  def attr_accessor_with_history(*names)
    names.each do |name|
      instance_var_name = "@#{name}".to_sym
      instance_history_var_name = "@history_#{name}".to_sym
      define_method(name) {instance_variable_get(instance_var_name)}
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set instance_var_name, value
        instance_variable_set(instance_history_var_name, []) unless instance_variable_get(instance_history_var_name)
        instance_variable_get(instance_history_var_name) << instance_variable_get(instance_var_name)
      end
      define_method("#{name}_history") {instance_variable_get("@history_#{name}".to_sym)}
    end
  end

  def strong_attr_accessor(var_name, var_class)
    instance_var_name = "@#{var_name}".to_sym
    define_method(var_name) {instance_variable_get(instance_var_name)}
    define_method("#{var_name}=".to_sym) do |value|
      raise 'Class validate error' unless value.instance_of? var_class

      instance_variable_set instance_var_name, value
    end
  end

end
