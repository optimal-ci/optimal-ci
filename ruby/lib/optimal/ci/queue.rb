module Optimal
  module CI
    class Queue
      def initialize(provider, command_arguments_string = "")
        @provider = provider
        @command_arguments_string = command_arguments_string
        @http_calls_count = 0
        @http_calls_time = 0.0
      end

      def push(files)
        params = {
          build_number: @provider.build_number,
          total_files: files,
          ci: @provider.name,
          command_arguments_string: @command_arguments_string,
          total_nodes: @provider.total_nodes
        }

        response = Client.post('/builds', params)

        response.code == 204
      rescue RestClient::Conflict
        true
      end

      def pop
        start = Time.now
        response = Client.get("/builds/#{@provider.build_number}/queue/pop")

        @http_calls_count += 1
        @http_calls_time += (Time.now - start).to_f

        return if response.code != 200

        JSON.parse(response.body)

      rescue RestClient::NotFound
        return nil
      end

      def report_duration(duration)
        params = {
          duration: duration,
          node_index: @provider.node_index
        }

        Client.patch("/builds/#{@provider.build_number}/report_duration", params)
      end

      def report_http_calls
        params = {
          http_calls_count: @http_calls_count,
          http_calls_time: @http_calls_time,
          node_index: @provider.node_index
        }

        Client.patch("/builds/#{@provider.build_number}/report_http_calls", params)
      end
    end
  end
end
