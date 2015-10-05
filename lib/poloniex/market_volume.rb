module Poloniex
  class MarketVolume < BasePoloniex
    attr_reader :name, :first_currency_name, :first_currency_volume, :last_currency_name, :last_currency_volume, :volume, :raw, :error

    # "BTC_1CR" => {
    #     "BTC" => "0.00705725",
    #     "1CR" => "94.00000000"
    # }

    def initialize(attrs = {})
      @name = attrs.first
      if !name.include?('total')
        # I'm so sorry
        first_key_value = attrs.last.to_a.first
        last_key_value = attrs.last.to_a.last

        @first_currency_name = first_key_value[0]
        @first_currency_volume = first_key_value[1]

        @last_currency_name = last_key_value[0]
        @last_currency_volume = last_key_value[1]
      else
        @volume = attrs.last
      end
      @raw = attrs
    end

    class << self
      def all
        response = download_markets
        response.map { |e| new(e) } if response.present?
      end

      def by_pair(pair)
        response = download_markets
        return new([pair, response[pair]]) if response[pair].present?
        nil
      end

      private

      def download_markets
        client.get('return24hVolume')
      end
    end
  end
end