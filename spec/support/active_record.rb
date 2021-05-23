logger = Logger.new($stdout)
logger.level = Logger::FATAL
ActiveRecord::Base.logger = logger

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
