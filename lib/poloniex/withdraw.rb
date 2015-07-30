module Poloniex
  class Withdraw < BasePoloniex
    attr_reader :error, :success, :transaction_id, :raw, :error

    def initialize(attrs = {})
      @error = attrs['error']
      @success = attrs['success']
      @transaction_id = attrs['transaction_id']
      @raw = attrs
    end

    def self.send(currency, amount, address)
      client.post('withdraw', currency: normalize_currency(currency), amount: amount, address: address)
    end
  end
end