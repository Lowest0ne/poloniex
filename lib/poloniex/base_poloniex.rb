module Poloniex
  class BasePoloniex
    private

    def self.normalize_response(response)
      response.is_a?(Array) ? response.last : response
    end

    def self.normalize_pair(pair)
      pair.upcase
    end

    def self.normalize_currency(currency)
      currency.upcase
    end

    def self.client
      @client ||= Poloniex.client
    end
  end
end