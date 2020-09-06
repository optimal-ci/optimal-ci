module RSpec
  module Optimal
    module Formatters
      class CustomFormatter
        RSpec::Core::Formatters.register self, :example_started

        def initialize(output)
          @output = output
        end

        def example_started(notification)
          @output << "example: " << notification.example.description
        end
      end
    end
  end
end
