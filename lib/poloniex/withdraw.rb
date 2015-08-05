module Poloniex
  class Withdraw < BasePoloniex
    attr_reader :error, :transaction_id, :raw, :success

    def initialize(attrs = {}, address)
      @error = attrs['error']
      @address = address
      @success = @error.nil?
      @raw = attrs
      @transaction_id = request_transaction_id(address) if @success
    end

    def self.send(currency, amount, address)
      response = client.post('withdraw', currency: normalize_currency(currency), amount: amount, address: address)
      new(self.prepare_response(response), address)
    end

    private

    def self.prepare_response(response)
      response.is_a?(Array) ?
        response.first :
        response
    end

    def request_transaction_id(address)
      transaction = Poloniex::Withdrawal.last_bunch_for_short_period_by_address(address).last
      transaction.id if transaction.present?
    end
  end
end