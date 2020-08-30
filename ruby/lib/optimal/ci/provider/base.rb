module Optimal
  module CI
    module Provider
      class Base
        def name
          self.class.name.split("::").last.downcase
        end

        def total_nodes
          raise "Not Implemented"
        end

        def node_index
          raise "Not Implemented"
        end

        def build_number
          raise "Not Implemented"
        end

        def commit_hash
          raise "Not Implemented"
        end

        def branch
          raise "Not Implemented"
        end
      end
    end
  end
end
