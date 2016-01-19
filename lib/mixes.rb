require_relative "mixes/version"
require_relative "mixes/configurator"
require_relative "mixes/extender"

module Mixes
  def mixes(mixed_module, *config)
    ::Mixes::Configurator.perform(mixed_module, *config)
    ::Mixes::Extender.perform(self, mixed_module)
  end
end

Object.extend(::Mixes)
