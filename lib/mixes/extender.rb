module Mixes
  module Extender
    def perform(target, source)
      target.send(:include, source)
      target.send(:extend, source.const_get(:ClassMethods)) if source.const_defined?(:ClassMethods)
    end
    module_function :perform
  end
end
