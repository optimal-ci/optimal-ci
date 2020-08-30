module Optimal
  module CI
    class Queue
      def initialize(build_number)
        @build_number = build_number
      end

      def push(files)
        puts "ENVVVVVVVVVVVVVVVVVVv"
        puts ENV.methods.grep(/OPTIMAL/).inspect

        ENV['OPTIMAL_CI_URL'] = 'http://localhost:3000'
        ENV['OPTIMAL_CI_TOKEN'] = 'test'

        response = ::RestClient.post(ENV['OPTIMAL_CI_URL'] + '/builds', {build_number: @build_number, total_files: files, ci: 'PLACE_HOLDER'}, { Authorization: ENV['OPTIMAL_CI_TOKEN'] })


        response.code == 204
      end
    end
  end
end
