require "rspec/core/formatters/base_text_formatter"
require "rspec/core/formatters/console_codes"

class RSpec::Core::Notifications::SummaryNotification
  def +(other)
    sum = self.class.new
    sum.duration = self.duration + other.duration
    sum.examples = self.examples + other.examples
    sum.failed_examples = self.failed_examples + other.failed_examples
    sum.load_time = self.load_time + other.load_time
    sum.errors_outside_of_examples_count = self.errors_outside_of_examples_count + other.errors_outside_of_examples_count
    sum.pending_examples = self.pending_examples + other.pending_examples

    sum
  end
end


module RSpec
  module Optimal
    module Formatters
      class DocumentationFormatter < RSpec::Core::Formatters::DocumentationFormatter
        RSpec::Core::Formatters.register self, :example_started, :example_group_started, :example_group_finished,
                            :example_passed, :example_pending, :example_failed

        @@summary_notifcation = nil

        def dump_summary(summary, finished = false)
          if finished
            super(@@summary_notifcation)
          else
            if @@summary_notifcation.nil?
              @@summary_notifcation = summary
            else
              @@summary_notifcation = @@summary_notifcation + summary
            end
          end
        end
      end
    end
  end
end
