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

describe "mixed_with" do
  let(:foo_class) do
    Class.new do
      mixes ::FooBar, :foo_config
    end
  end

  let(:bar_class) do
    Class.new do
      mixes ::FooBar, :bar_config
    end
  end

  let(:baz_class) do
    Class.new do
      mixes ::FooBar
    end
  end

  context "on class level" do
    it "includes FooBar module" do
      expect(foo_class.included_modules).to include(FooBar)
      expect(bar_class.included_modules).to include(FooBar)
      expect(baz_class.included_modules).to include(FooBar)
    end

    it "extends FooBar::ClassMethods" do
      expect(foo_class.methods(true)).to include(:foobar_class_method)
      expect(bar_class.methods(true)).to include(:foobar_class_method)
      expect(baz_class.methods(true)).to include(:foobar_class_method)
    end
  end

  context "on instance level" do
    subject(:foo_object) { foo_class.new }
    subject(:bar_object) { bar_class.new }
    subject(:baz_object) { baz_class.new }

    it "includes FooBar module methods" do
      expect(foo_object.methods(true)).to include(:foobar_instance_method)
      expect(bar_object.methods(true)).to include(:foobar_instance_method)
      expect(baz_object.methods(true)).to include(:foobar_instance_method)
    end

    it "passes configuration for each inclusion" do
      expect(foo_object.passed_configuration).to eql(:foo_config)
      expect(bar_object.passed_configuration).to eql(:bar_config)
      expect(baz_object.passed_configuration).to eql(nil)
    end
  end
end
