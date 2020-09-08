module RSpec
  module Optimal
    class Runner < ::Optimal::CI::Runner
      def command
        'bundle exec rspec'
      end

      def files_end_with
        "_spec.rb"
      end

      def paths
        return ['spec/'] if @args.empty?

        ::RSpec::Core::Parser.parse(@args)[:files_or_directories_to_run]
      end

      def run_examples(examples)
        args = ['--format', 'RSpec::Optimal::Formatters::DocumentationFormatter'] + examples
        RSpec::Core::Runner.run(args)
        RSpec.clear_examples
      end

      def finished
        ::RSpec::Optimal::Formatters::DocumentationFormatter.new($stdout).dump_summary(nil, true)
      end
    end
  end
end

