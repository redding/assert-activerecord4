require "assert"
require "assert-activerecord4"

require "assert-activerecord4/adapter"

module AssertActiveRecord4

  class UnitTests < Assert::Context
    desc "AssertActiveRecord4"
    setup do
      @module = AssertActiveRecord4
    end
    subject{ @module }

    should "set AssetActiveRecord's adapter" do
      exp = AssertActiveRecord4::Adapter
      assert_instance_of exp, AssertActiveRecord.adapter
    end

  end

end
