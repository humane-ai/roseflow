# Roseflow: TensorFlow for Ruby

[TensorFlow™](https://tensorflow.org) is an open source software library for numerical computation using data flow graphs. Nodes in the graph represent mathematical operations, while the graph edges represent the multidimensional data arrays (tensors) communicated between them. The flexible architecture allows you to deploy computation to one or more CPUs or GPUs in a desktop, server, or mobile device with a single API.

The [TensorFlow C API](https://www.tensorflow.org/code/tensorflow/c/c_api.h) exposes internal core functions of TensorFlow that enable constructing and executing TensorFlow graphs. This gem providers access to the complete TensorFlow C API from within Ruby.

**WARNING**

_This gem is still early in development and does not yet provide any easy way to use TensorFlow in Ruby. All C API calls are mapped over the FFI, but some of them are still incomplete or not properly covered by tests._

## Installation

Pre-requisites:
- TensorFlow library

Add this line to your application's Gemfile:

```ruby
gem 'roseflow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install roseflow

### Installing TensorFlow

You must have TensorFlow library installed to use this gem.

#### Mac OSX

You can install TensorFlow library with Homebrew

    $ brew install libtensorflow

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/humane-ai/roseflow.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
