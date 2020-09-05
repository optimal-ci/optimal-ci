module Optimal
  module CI
    class Runner
      def measure(&block)
        start = Time.now
        block.call
        (Time.now - start).to_f
      end

      def initialize(args = [])
        @command_arguments_string = args.join(" ")
        @args = args
        @measured_files = {}

        if @args.empty?
          @paths = [dir]
        else
          @paths = @args
        end
      end

      def run
        provider = Optimal::CI::Provider.detect

        if provider
          queue = Optimal::CI::Queue.new(provider, @command_arguments_string)
          queue.push(total_files)

          start_time = Time.now.to_i

          while files = queue.pop
            example_time = measure { run_examples(files) }
            if files.count == 1
              @measured_files[files.first] = [File.mtime(files.first).to_i, example_time]
            end
          end

          duration = Time.now.to_i - start_time

          queue.report(duration, @measured_files)

        else
          Optimal::CI::Logger.info("provider not found")
          system("#{command} #{@args.join(' ')}")
        end
      end

      def run_examples(examples)
        raise "Not Implemented"
      end

      def total_files
        return @total_files if @total_files

        @total_files = []

        @paths.each do |path|
          if path.end_with?(files_end_with)
            @total_files << path
          else
            @total_files << Dir.glob("#{path.chomp("/")}/**/*#{files_end_with}")
          end
        end

        @total_files.flatten!

        @total_files
      end
    end
  end
end
