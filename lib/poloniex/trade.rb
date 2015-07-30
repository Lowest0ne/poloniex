module Poloniex
  class Trade < BasePoloniex
    attr_reader :id, :error, :resulting_trades, :raw, :error

    def initialize(attrs = {})
      @id = attrs['orderNumber']
      @error = attrs['error']
      @resulting_trades = attrs['resultingTrades']
      @raw = attrs
    end

    def self.buy(pair, rate, amount)
      response = client.post('buy', currencyPair: normalize_pair(pair), rate: rate, amount: amount)
      new normalize_response response
    end

    def self.sell(pair, rate, amount)
      response = client.post('sell', currencyPair: normalize_pair(pair), rate: rate, amount: amount)
      new normalize_response response
    end
  end
end