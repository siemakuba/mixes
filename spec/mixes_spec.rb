require 'mixes'

module FooBar
  def foobar_instance_method
  end

  def self.included(base)
    new_method_name   = mixin_configuration[:name]
    new_method_value  = mixin_configuration[:value]

    base.instance_eval do
      define_method(new_method_name) do
        new_method_value
      end
    end
  end

  module ClassMethods
    def foobar_class_method
    end
  end
end

class FooClass
  mixes ::FooBar, name: :foo, value: :FOO
end

class BarClass
  mixes ::FooBar, name: :bar, value: :BAR
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

    context "defineds methods on host objects based on passed configuration" do
      it "for FooClass instances" do
        expect(foo_object.foo).to eql(:FOO)
        expect{foo_object.bar}.to raise_error(NoMethodError)
      end

      it "for BarClass instances" do
        expect(bar_object.bar).to eql(:BAR)
        expect{bar_object.foo}.to raise_error(NoMethodError)
      end
    end
  end
end
