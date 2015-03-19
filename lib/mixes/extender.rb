module Mixes
  module Extender
    def perform(target, source)
      target.send(:extend, source.const_get(:ClassMethods)) if source.const_defined?(:ClassMethods)
      target.send(:include, source)
    end
    module_function :perform
  end
end
