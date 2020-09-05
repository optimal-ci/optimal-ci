module Optimal
  module CI
    class Client
      class << self
        def post(path, payload = {})
          execute(:post, path, payload)
        end

        def get(path)
          execute(:get, path)
        end

        def patch(path, payload = {})
          execute(:patch, path, payload)
        end

        def execute(method, path, payload = {})
          url = ENV['OPTIMAL_CI_URL'] + path
          headers = { Authorization: ENV['OPTIMAL_CI_TOKEN'] }

          RestClient::Request.execute(method: method, url: url, payload: payload, headers: headers)
        end
      end
    end
  end
end
