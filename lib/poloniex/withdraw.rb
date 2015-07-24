module Poloniex
  class Withdraw < BasePoloniex
    attr_reader :error, :success, :transaction_id, :raw

    def initialize(attrs = {})
      @error = attrs['error']
      @success = attrs['success']
      @transaction_id = attrs['transaction_id']
      @raw = attrs
    end

    def self.send(currency, amount, address)
      response = client.post('withdraw', currency: normalize_currency(currency), amount: amount, address: address)
      prepare_result(response, address) if response.present?
    end

    private

    def self.prepare_result(response, address)
      attrs = if response['response'].present?
        {
          'success' => '1',
          'transaction_id' => Withdrawal.last_withdrawals_by_address(address).id
        }
      elsif response['error'].present?
        {
          'success' => '0',
          'error' => response['error']
        }
      end
    end
  end
end