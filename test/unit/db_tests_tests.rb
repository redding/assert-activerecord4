require "assert"
require "assert-activerecord/db_tests"

# Note: this is "unit" test that is acting like a "system-ish" test between
# this adapter gem and AssertActiveRecord's DbTests.  It is a copy of the
# same unit tests in AssertActiveRecord but instead of stubbing the adapter,
# it stubs ActiveRecord directly.

class AssertActiveRecord::DbTests

  class UnitTests < Assert::Context
    desc "AssertActiveRecord::DbTests"
    setup do
      @transaction_called = false
      Assert.stub(ActiveRecord::Base, :transaction) do |&block|
        @transaction_called = true
        block.call
      end

      @class = AssertActiveRecord::DbTests
    end
    subject{ @class }

    should "add an around callback to run tests in a rollback transaction" do
      assert_equal 1, subject.arounds.size
      callback = subject.arounds.first

      block_yielded_to = false
      assert_raises(ActiveRecord::Rollback) do
        callback.call(proc{ block_yielded_to = true })
      end
      assert_true @transaction_called
      assert_true block_yielded_to
    end

  end

end
