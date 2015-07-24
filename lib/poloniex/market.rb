module Poloniex
  class Market < BasePoloniex
    attr_reader :name, :last, :lowest_ask, :highest_bid, :percent_change, :base_volume, :quote_volume, :is_frozen, :high_24_hr, :low_24_hr, :raw
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

    def self.all
      response = client.get('returnTicker')
      response.map { |e| new(e) } if response.present?
    end

    def self.by_pair(pair)
      all.detect { |e| e.name == normalize_pair(pair) }
    end
  end
end