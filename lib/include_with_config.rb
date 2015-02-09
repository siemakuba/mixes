require "include_with_config/version"
require "include_with_config/configurator"
require "include_with_config/extender"

module IncludeWithConfig
  def mixin(mixed_module, *config)
    ::IncludeWithConfig::Configurator.perform(mixed_module, *config)
    ::IncludeWithConfig::Extender.perform(self, mixed_module)
  end
end

Object.extend(::IncludeWithConfig)
