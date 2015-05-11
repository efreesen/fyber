require 'httparty'
require './app/domains/parameterization/base'

module Fyber
  module Integration
    class OfferAPIAdapter
      def initialize(uid, pub0, page)
        @query_string  = Fyber::Parameterization::Base.generate(uid, pub0, page)

        @message = error_message(uid, pub0, page) unless query_string
      end

      def self.request(uid, pub0, page)
        instance = self.new(uid, pub0, page)

        instance.request
      end

      def request
        return message if message

        response = HTTParty.get(url)

        @body = JSON.parse(response.body)

        if response.success?
          render_response
        else
          body["message"]
        end
      end

      private
      attr_accessor :body, :message, :query_string

      def error_message(uid, pub0, page)
        return "uid must be passed." if uid.nil? || uid.size == 0
        return "pub0 must be passed." if pub0.nil? || pub0.size == 0
        return "page must be passed." if page.nil?
      end

      def render_response
        if body["code"] == "NO_CONTENT"
          'No offers available'
        else
          map_offers
        end
      end

      def map_offers
        body["offers"].map do |offer|
          {
            title: offer["title"],
            thumbnail: offer["thumbnail"]["lowres"],
            payout: offer["payout"]
          }
        end
      end

      def url
        @url ||= begin
          host = Settings.fyber.host
          path = Settings.fyber.path
          base_url = "#{host}#{path}"

          "http://#{base_url}?#{query_string}"
        end
      end
    end
  end
end
