require 'rack'

require './app/domains/cryptography/hash_key'
require './app/settings'

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
        return unless parameters_present?

        apikey = parameters.delete("api_key")

        query_string(apikey)
      end

      private
      attr_accessor :uid, :pub0, :page, :parameters

      def parameters
        @parameters ||= Settings.fyber.parameters.dup.merge!("uid" => uid, "pub0" => pub0, "page" => page, "timestamp" => timestamp)
      end

      def query_string(apikey)
        sorted_parameters = Hash[parameters.sort]

        query = Rack::Utils.build_query(sorted_parameters)

        string_for_hash = "#{query}&#{apikey}"

        query += "&hashkey=#{hashkey(string_for_hash)}"
      end

      def parameters_present?
        present?(uid) && present?(pub0) && present?(page)
      end

      def present?(attribute)
        result = attribute.nil?
        result ||= attribute.size > 0 if attribute.respond_to? :size
      end

      def timestamp
        Time.now.to_i
      end

      def hashkey(string)
        Fyber::Cryptography::HashKey.calculate(string)
      end
    end
  end
end
