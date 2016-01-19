# Mixes

Simple Ruby objects mixin, with configuration.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mixes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mixes

## Usage
### Plain object extending

Include your module inside any Ruby object using the `mixes` syntax:

```ruby
module FooModule
  def instance_method
  end

  module ClassMethods
    def class_method
    end
  end
end

class FooClass
  mixes FooModule
end
```

`FooModule` module level methods would become instance methods within host object, and `FooModule::ClassMethods` methods would become class level methods.

### Extending and configuring extended objects
You can pass a second argument to `mixes` method, holding the per-extension configuration values for module beeing mixed in.

```ruby
class FooClass
  mixes FooModule, :foo
  # OR
  mixes FooModule, {foo: :bar}
  # OR
  mixes FooModule, [:foo, :bar]
  # OR
  # any other configuration values
end
```

This values would be available inside extended module throught the `mixin_configuration` class level accessor:

```ruby
module FooModule
  def self.included(base)
    # prepare module host object based on values held by mixin_configuration
  end
end

class FooClass
  mixes FooModule, :foo
end
```

## Contributing

1. Fork it ( https://github.com/siemakuba/mixes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
