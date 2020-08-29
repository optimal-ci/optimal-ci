module Optimal
  class CI
    class Runner
      def initialize(args = [])
        @args = args

        if @args.empty?
          @paths = [dir]
        else
          @paths = @args
        end
      end

      def total_files
        return @total_files if @total_files

        @total_files = []

        @paths.each do |path|
          if path.end_with?(files_end_with)
            @total_files << path
          else
            @total_files << Dir.glob("#{path}/**/*#{files_end_with}")
          end
        end

        @total_files.flatten!

        @total_files
      end
    end
  end
end