module Optimal
  module CI
    module Provider
      class Travis < Base
        def total_nodes
          ENV['CI_NODE_TOTAL']
        end

        def node_index
          ENV['CI_NODE_INDEX']
        end

        def build_number
          ENV['TRAVIS_BUILD_NUMBER']
        end

        def commit_hash
          ENV['TRAVIS_COMMIT']
        end

        def branch
          ENV['TRAVIS_BRANCH']
        end
      end
    end
  end
end

