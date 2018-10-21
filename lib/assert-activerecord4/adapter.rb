require "active_record"
require "active_record/tasks/database_tasks"
require "assert-activerecord/adapter"

module AssertActiveRecord4

  class Adapter
    include AssertActiveRecord::Adapter

    def self.database_tasks
      ActiveRecord::Tasks::DatabaseTasks
    end

    def drop_db
      self.class.database_tasks.drop_current(self.test_env_name)
    end

    def create_db
      self.class.database_tasks.create_current(self.test_env_name)
    end

    def load_schema
      # ActiveRecord::Base.schema_format can either be `:ruby` or `:sql`
      self.class.database_tasks.load_schema(
        ActiveRecord::Base.schema_format,
        ENV["SCHEMA"],
        self.test_env_name
      )
    end

    def connect_db
      ActiveRecord::Base.establish_connection(self.test_env_name)
    end

  end

end
