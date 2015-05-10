require './app/settings'

module Fyber
  module Cryptography
    class HashKey
      def initialize(string)
        @string  = string
      end

      def self.calculate(string)
        instance = self.new(string)

        instance.calculate
      end

      def calculate
        '7a2b1604c03d46eec1ecd4a686787b75dd693c4d'
      end

      private
      attr_accessor :string

    end
  end
end
