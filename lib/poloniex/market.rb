module Poloniex
  class Market < BasePoloniex
    attr_reader :name, :last, :lowest_ask, :highest_bid, :percent_change, :base_volume, :quote_volume, :is_frozen, :high_24_hr, :low_24_hr, :raw, :error
    # "BTC_1CR", {"last"=>"0.00009210", "lowestAsk"=>"0.00009700", "highestBid"=>"0.00009210", "percentChange"=>"0.00000000", "baseVolume"=>"0.03367644", "quoteVolume"=>"365.65077443", "isFrozen"=>"0", "high24hr"=>"0.00009210", "low24hr"=>"0.00009210"}
    def initialize(attrs = {})
      @name = attrs.first
      @last = attrs.last['last']
      @lowest_ask = attrs.last['lowestAsk']
      @highest_bid = attrs.last['highestBid']
      @percent_change = attrs.last['percentChange']
      @base_volume = attrs.last['baseVolume']
      @quote_volume = attrs.last['quoteVolume']
      @is_frozen = attrs.last['isFrozen']
      @high_24_hr = attrs.last['high24hr']
      @low_24_hr = attrs.last['low24hr']
      @raw = attrs
    end

    class << self
      def all
        response = download_ticker
        response.map { |e| new(e) } if response.present?
      end

      def by_pair(pair)
        response = download_ticker
        return new([pair, response[pair]]) if response[pair].present?
        nil
      end

      private

      def download_ticker
        client.get('returnTicker')
      end
    end
  end
end