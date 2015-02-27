require "mixes/version"
require "mixes/configurator"
require "mixes/extender"

module Mixes
  def mixes(mixed_module, *config)
    ::Mixes::Configurator.perform(mixed_module, *config)
    ::Mixes::Extender.perform(self, mixed_module)
  end
end

Object.extend(::Mixes)
