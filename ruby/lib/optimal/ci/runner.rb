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
              @measured_files[files.first] = [checksum(files.first), example_time]
            end
          end

          duration = Time.now.to_i - start_time

          finished
          queue.report(duration, @measured_files)

        else
          Optimal::CI::Logger.info("provider not found")
          system("#{command} #{@args.join(' ')}")
        end
      end

      def run_examples(examples)
        raise "Not Implemented"
      end

      def finished
        raise "Not Implemented"
      end

      def total_files
        return @total_files if @total_files

        @total_files = {}
        files = []

        paths.each do |path|
          if path.end_with?(files_end_with)
            files << path
          else
            files << Dir.glob("#{path.chomp("/")}/**/*#{files_end_with}")
          end
        end

        files.flatten!

        files.each do |file|
          @total_files[file] = checksum(file)
        end

        @total_files
      end

      def checksum(file)
        Digest::MD5.hexdigest(File.read(file))
      end
    end
  end
end
