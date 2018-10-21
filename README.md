# AssertActiveRecord4

AssertActiveRecord adapter for ActiveRecord 4.  See https://github.com/redding/assert-activerecord for reference.

## Usage

### Reset the test db for test runs

```ruby
# in test/helper.rb
require "assert-activerecord4"
AssertActiveRecord.reset_db
```

TODO: transactional DbTests

## Installation

Add this line to your application's Gemfile:

    gem "assert-activerecord4"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install assert-activerecord4

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Added some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
