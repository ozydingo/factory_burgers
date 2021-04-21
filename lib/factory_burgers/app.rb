module FactoryBurgers
  class App
    def call(env)
      static_app.call(env)
    end

    def static_app
      Rack::Static.new(nil, static_options)
    end

    def static_options
      {urls: [""], root: asset_path, index: 'index.html'}
    end

    def asset_path
      @asset_path ||= FactoryBurgers.root.join("assets/")
    end
  end
end
