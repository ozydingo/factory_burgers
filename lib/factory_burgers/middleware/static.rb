module FactoryBurgers
  module Middleware
    class Static
      def call(env)
        rack_static.call(env)
      end

      def rack_static
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
end
