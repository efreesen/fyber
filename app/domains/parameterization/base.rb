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
        result_string = "appid=#{appid}"
        result_string += "&device_id=#{device_id}"
        result_string += "&ip=#{ip}"
        result_string += "&locale=#{locale}"
        result_string += "&offer_types=#{offer_types}"
        result_string += "&page=#{page}"
        result_string += "&ps_time=#{ps_time}"
        result_string += "&pub0=#{pub0}"
        result_string += "&timestamp=#{timestamp}"
        result_string += "&uid=#{uid}"
        result_string += "&hashkey=#{hashkey(result_string)}"
      end

      private
      attr_accessor :uid, :pub0, :page

      def timestamp
        Time.now.to_i
      end

      def appid
        Settings.fyber.appid
      end

      def format
        Settings.fyber.format
      end

      def device_id
        Settings.fyber.device_id
      end

      def ip
        Settings.fyber.ip
      end

      def locale
        Settings.fyber.locale
      end

      def ps_time
        Settings.fyber.ps_time
      end

      def offer_types
        Settings.fyber.offer_types
      end

      def hashkey(string)
        '7a2b1604c03d46eec1ecd4a686787b75dd693c4d'
      end
    end
  end
end
