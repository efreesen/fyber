module Fyber
  module Parameterization
    class Base
      def initialize(hash={})
        @hash = hash
      end

      def self.generate(hash)
        instance = self.new(hash)

        instance.generate
      end

      def generate
      end
    end
  end
end
