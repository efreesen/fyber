module Fyber
  module Parameterization
    class Base
      def initialize(uid, pub0, page)
        @uid  = uid
        @pub0 = pub0
        @page = page
      end

      def self.generate(uid, pub0, page)
        instance = self.new(uid, pub0, page)

        instance.generate
      end

      def generate
      end
    end
  end
end
