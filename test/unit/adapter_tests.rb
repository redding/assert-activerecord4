require "assert"
require "assert-activerecord4/adapter"

require "active_record"
require "active_record/tasks/database_tasks"

class AssertActiveRecord4::Adapter

  class UnitTests < Assert::Context
    desc "AssertActiveRecord4::Adapter"
    setup do
      @class = AssertActiveRecord4::Adapter
    end
    subject{ @class }

    should "mixin AssertActiveRecord::Adapter" do
      assert_includes AssertActiveRecord::Adapter, subject
    end

    should have_imeths :database_tasks

    should "know its database tasks" do
      assert_equal ActiveRecord::Tasks::DatabaseTasks, subject.database_tasks
    end

  end

  class InitTests < UnitTests
    desc "when init"
    setup do
      @tasks_spy = TasksSpy.new
      Assert.stub(@class, :database_tasks){ @tasks_spy }

      @establish_connection_called_with = nil
      Assert.stub(ActiveRecord::Base, :establish_connection) do |*args|
        @establish_connection_called_with = args
      end

      @orig_schema_value = ENV["SCHEMA"]
      ENV["SCHEMA"] = Factory.path

      @adapter = @class.new
    end
    teardown do
      ENV["SCHEMA"] = @orig_schema_value
    end
    subject{ @adapter }

    should have_imeths :drop_db, :create_db, :load_schema, :connect_db

    should "be able to drop a db" do
      assert_equal 0, @tasks_spy.drop_current_called_count

      subject.drop_db
      assert_equal 1, @tasks_spy.drop_current_called_count

      exp = [subject.test_env_name]
      assert_equal exp, @tasks_spy.drop_current_called_withs.first
    end

    should "know how to create a db" do
      assert_equal 0, @tasks_spy.create_current_called_count

      subject.create_db
      assert_equal 1, @tasks_spy.create_current_called_count

      exp = [subject.test_env_name]
      assert_equal exp, @tasks_spy.create_current_called_withs.first
    end

    should "know how to load a schema" do
      assert_equal 0, @tasks_spy.load_schema_called_count

      subject.load_schema
      assert_equal 1, @tasks_spy.load_schema_called_count

      exp = [
        ActiveRecord::Base.schema_format,
        ENV["SCHEMA"],
        subject.test_env_name
      ]
      assert_equal exp, @tasks_spy.load_schema_called_withs.first
    end

    should "know how to connect to a db" do
      subject.connect_db

      exp = [subject.test_env_name]
      assert_equal exp, @establish_connection_called_with
    end

  end

  class TasksSpy

    attr_reader :drop_current_called_withs, :create_current_called_withs
    attr_reader :load_schema_called_withs

    def initialize
      @drop_current_called_withs   = []
      @create_current_called_withs = []
      @load_schema_called_withs    = []
    end

    def drop_current_called_count
      self.drop_current_called_withs.size
    end

    def create_current_called_count
      self.create_current_called_withs.size
    end

    def load_schema_called_count
      self.load_schema_called_withs.size
    end

    def drop_current(*args)
      self.drop_current_called_withs << args
    end

    def create_current(*args)
      self.create_current_called_withs << args
    end

    def load_schema(*args)
      self.load_schema_called_withs << args
    end

  end

end
