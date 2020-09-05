module Optimal
  module CI
    class Client
      class << self
        def post(path, params = {}, headers = {})
          execute(:post, path, params, headers)
        end

        def get(path, params = {}, headers = {})
          execute(:get, path, params, headers)
        end

        def patch(path, params = {}, headers = {})
          execute(:patch, path, params, headers)
        end

        def execute(method, path, params, headers)
          url = ENV['OPTIMAL_CI_URL'] + path
          headers.merge!({ Authorization: ENV['OPTIMAL_CI_TOKEN'], params: params })

          RestClient::Request.execute(method: method, url: url, timeout: 10, headers: headers)
        end
      end
    end
  end
end
