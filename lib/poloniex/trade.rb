module Poloniex
  class Trade < BasePoloniex
    def self.buy(pair, rate, amount)
      client.post('buy', currencyPair: normalize_pair(pair), rate: rate, amount: amount)
    end

    def self.sell(pair, rate, amount)
      client.post('sell', currencyPair: normalize_pair(pair), rate: rate, amount: amount)
    end
  end
end