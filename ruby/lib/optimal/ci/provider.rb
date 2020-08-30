module Optimal
  module CI
    module Provider
      def self.detect
        list = constants - [:Base]

        list.each do |p|
          provider = const_get(p).new

          return provider unless provider.build_number.nil?
        end

        nil
      end
    end
  end
end

