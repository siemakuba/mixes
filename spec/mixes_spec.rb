require 'mixes'

module FooBar
  def foobar_instance_method
  end

  def self.included(base)
    config = mixin_configuration

    base.instance_eval do
      define_method(:passed_configuration) do
        config
      end
    end
  end

  module ClassMethods
    def foobar_class_method
    end
  end
end

class FooClass
  mixes ::FooBar, :foo_config
end

class BarClass
  mixes ::FooBar, :bar_config
end

describe "mixed_with" do
  context "on class level" do
    it "includes FooBar module" do
      expect(FooClass.included_modules).to include(FooBar)
      expect(BarClass.included_modules).to include(FooBar)
    end

    it "extends FooBar::ClassMethods" do
      expect(FooClass.methods(true)).to include(:foobar_class_method)
      expect(BarClass.methods(true)).to include(:foobar_class_method)
    end
  end

  context "on instance level" do
    subject(:foo_object) { FooClass.new }
    subject(:bar_object) { BarClass.new }

    it "includes FooBar module methods" do
      expect(foo_object.methods(true)).to include(:foobar_instance_method)
      expect(bar_object.methods(true)).to include(:foobar_instance_method)
    end

    it "passes configuration for each inclusion" do
      expect(foo_object.passed_configuration).to eql(:foo_config)
      expect(bar_object.passed_configuration).to eql(:bar_config)
    end
  end
end
