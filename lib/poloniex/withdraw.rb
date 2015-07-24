module Poloniex
  class Withdraw < BasePoloniex
    def self.send(currency, amount, address)
      client.post('withdraw', currency: normalize_currency(currency), amount: amount, address: address)
    end
  end
end