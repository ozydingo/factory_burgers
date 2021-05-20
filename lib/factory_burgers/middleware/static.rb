module FactoryBurgers
  module Middleware
    class Static
      def call(env)
        return slashpath_redirect(env["REQUEST_PATH"]) if slashpath_redirect?(env)

        rack_static.call(env)
      end

      def slashpath_redirect?(env)
        env["REQUEST_PATH"] == env["SCRIPT_NAME"] && env["REQUEST_PATH"][-1] != "/"
      end

      def slashpath_redirect(path)
        return [
          302,
          {'Location' => path + "/", 'Content-Type' => 'text/html', 'Content-Length' => '0'},
          [],
        ]
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
