require 'include_with_config'

module Foo
  def foo_instance_method
    __method__
  end

  def self.included(base)
    base.const_set('MIXIN_CONFIG', mixin_configuration)
  end

  module ClassMethods
    def foo_class_method
      __method__
    end
  end
end

class ClassWithMixin
  mixin ::Foo, :passed_config_value
end

class AnotherClassWithMixin
  mixin ::Foo, :another_passed_config_value
end

describe ClassWithMixin do
  context 'Class level' do
    specify {
      expect(described_class.included_modules).to include(Foo)
    }

    specify {
      expect(described_class.foo_class_method).to eql(:foo_class_method)
    }

    specify {
      expect(ClassWithMixin.const_get('MIXIN_CONFIG')).to eql(:passed_config_value)
      expect(AnotherClassWithMixin.const_get('MIXIN_CONFIG')).to eql(:another_passed_config_value)
    }
  end

  context 'instance level' do
    specify {
      expect(subject.foo_instance_method).to eql(:foo_instance_method)
    }
  end
end
