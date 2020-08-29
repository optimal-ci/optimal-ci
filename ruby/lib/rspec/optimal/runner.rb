module RSpec
  class Optimal
    class Runner < ::Optimal::CI::Runner
      def command
        'rspec'
      end

      def dir
        'spec'
      end

      def files_end_with
        "_spec.rb"
      end
    end
  end
end
