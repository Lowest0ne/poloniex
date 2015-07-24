module Poloniex
  class Order < BasePoloniex
    # {"orderNumber"=>"199638996", "type"=>"sell", "rate"=>"1.00000000", "amount"=>"1.00000000", "total"=>"1.00000000", "date"=>"2015-07-24 12:42:10", "margin"=>0}
    attr_reader :id, :type, :rate, :amount, :total, :date, :margin, :raw

    def initialize(attrs = {})
      @id = attrs['orderNumber']
      @type = attrs['type']
      @rate = attrs['rate']
      @amount = attrs['amount']
      @total = attrs['total']
      @date = attrs['date']
      @margin = attrs['margin']
      @raw = attrs
    end

    def self.open_orders(pair)
      response = client.post('returnOpenOrders', currencyPair: normalize_pair(pair))
      response.map { |e| new(e) } if response.present?
    end

    def self.cancel_order(pair, order_number)
      client.post('cancelOrder', currencyPair: normalize_pair(pair), orderNumber: order_number)
    end
  end
end