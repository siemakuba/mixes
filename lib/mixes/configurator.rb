module Mixes
  module Configurator
    def perform(source, config)
      source.send(:extend, ::Mixes::Configurator::Extension)
      source.mixin_configuration = config
    end
    module_function :perform

    module Extension
      def mixin_configuration=(value)
        @mixin_configuration = value
      end

      def mixin_configuration
        @mixin_configuration
      end
    end
  end
end
