module Poloniex
  class History < BasePoloniex
    def self.all_for(pair)
      client.post('returnTradeHistory', currencyPair: normalize_pair(pair))
    end
  end
end