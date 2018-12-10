# PutsDebug

This simple gem adds method pd() to Ruby that helps with puts debugging. 
I found myself copying this method from project to project that is why I decided to move it to gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'puts_debug'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puts_debug

## Usage

Adds method pd (Puts Debugging) to Ruby. Defined in Kernel module which is included into Object class so this method
is accessible from everywhere. Output is sent to standard error stream (stderr) so it could be further separated
from standard output like this:

  
    $ rails s 2>> error

then you can

  
    $ tail -f error
  
 to watch error stream output.
 
 Usage examples: 
  
```ruby 

# Method signature: 

def pd(args)
  # ...
end  


pd('something') =>
============================================================
something
============================================================

pd(data: 'something', data_color: 'magenta', lines: :none) =>
something

pd(name: 'Yogurt') =>
============================================================
name: Yogurt
============================================================
  
pd(data: 1, symbol: '-', margin: 1) =>
 
------------------------------------------------------------
1
------------------------------------------------------------

pd(data: {a: 1, b: 3}, symbol: '*') =>
************************************************************
a: 1
b: 3
************************************************************
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/puts_debug. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PutsDebug project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/puts_debug/blob/master/CODE_OF_CONDUCT.md).
