# AssertActiveRecord4

AssertActiveRecord adapter for ActiveRecord 4.  See https://github.com/redding/assert-activerecord for reference.

## Usage

### Reset the test db for test runs

```ruby
# in test/helper.rb
require "assert-activerecord4"
AssertActiveRecord.reset_db
```

### Running database tests in a transaction

```ruby
# in test/helper.rb
require "assert-activerecord4"
class DbTests < AssertActiveRecord::DbTests
  # put any extra setup / teardown logic here
end
```

Then in a test that needs to interact with the database:

```ruby
require "assert"
require "blog_record"

class BlogRecord

  class SystemTests < DbTests
    # all tests in this context will be run in a transaction
  end

end
```

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
