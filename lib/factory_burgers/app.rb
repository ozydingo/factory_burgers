Dir[Pathname(__dir__).join("middleware/*")].sort.each do |file|
  require file
end

module FactoryBurgers
  # This is the main mounted app, handling all FactoryBugers requests
  App = Rack::Builder.new do
    map("/data") { run Middleware::Data.new }
    map("/build") { run Middleware::Build.new }
    run Middleware::Static.new
  end
end
