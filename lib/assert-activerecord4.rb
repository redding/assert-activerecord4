require "assert-activerecord"

require "assert-activerecord4/version"
require "assert-activerecord4/adapter"

module AssertActiveRecord4
end

AssertActiveRecord.adapter(AssertActiveRecord4::Adapter.new)
