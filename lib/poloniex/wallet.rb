module Poloniex
  class Wallet < BasePoloniex
    attr_reader :currency, :balance, :raw
    def initialize(attrs = {})
      @currency = attrs.first
      @balance = attrs.last
      @raw = attrs
    end

    def self.balances
      response = client.post('returnBalances')
      response.map { |e| new(e)  } if response.present?
    end

    def self.balance_by_currency(currency)
      balances.detect { |e| e.currency == normalize_currency(currency) }
    end
  end
end