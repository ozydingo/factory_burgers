Dir[Pathname(__dir__).join("middleware/*")].each do |file|
  require file
end

module FactoryBurgers
  App = Rack::Builder.new do
    map "/data" do
      run Middleware::Data.new
    end

    map "/build" do
      run Middleware::Build.new
    end

    run Middleware::Static.new
  end
end
