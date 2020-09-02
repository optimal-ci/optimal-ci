module Optimal
  module CI
    class Logger
      class << self
        def info(string)
          puts "OPTIMAL-CI ->>> #{string}"
        end
      end
    end
  end
end
