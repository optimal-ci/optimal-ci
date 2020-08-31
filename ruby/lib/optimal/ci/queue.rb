module Optimal
  module CI
    class Queue
      def initialize(provider, command_arguments_string = "")
        @provider = provider
        @command_arguments_string = command_arguments_string

        raise "OPTIMAL_CI_URL is not valid ENV" if ENV['OPTIMAL_CI_URL'].nil?
        raise "OPTIMAL_CI_TOKEN is not valid ENV" if ENV['OPTIMAL_CI_TOKEN'].nil?
      end

      def push(files)
        params = {
          build_number: @provider.build_number,
          total_files: files,
          ci: @provider.name,
          command_arguments_string: @command_arguments_string
        }

        response = ::RestClient.post(ENV['OPTIMAL_CI_URL'] + '/builds', params, { Authorization: ENV['OPTIMAL_CI_TOKEN'] })

        response.code == 204
      rescue RestClient::Conflict
        true
      end

      def pop
        response = ::RestClient.get(ENV['OPTIMAL_CI_URL'] + "/builds/#{@provider.build_number}/get_one_file", { Authorization: ENV['OPTIMAL_CI_TOKEN'] })

        return if response.code != 200

        JSON.parse(response.body)

      rescue RestClient::NotFound
        return nil
      end
    end
  end
end
