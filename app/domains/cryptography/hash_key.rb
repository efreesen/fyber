require 'digest/sha1'

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
        return unless string && string.size > 0

        Digest::SHA1.hexdigest(string).downcase
      end

      private
      attr_accessor :string
    end
  end
end
