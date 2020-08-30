module Optimal
  module CI
    module Provider
      class Circle < Base
        def total_nodes
          ENV['CIRCLE_NODE_TOTAL']
        end

        def node_index
          ENV['CIRCLE_NODE_INDEX']
        end

        def build_number
          ENV['CIRCLE_BUILD_NUM']
        end

        def commit_hash
          ENV['CIRCLE_SHA1']
        end

        def branch
          ENV['CIRCLE_BRANCH']
        end
      end
    end
  end
end
