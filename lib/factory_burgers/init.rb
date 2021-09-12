require Pathname(__dir__).join("factory_bot_adapter.rb")

begin
  require "factory_bot"
rescue LoadError
  raise LoadError, "Could not load factory_bot. Please make sure it is installed."
end
