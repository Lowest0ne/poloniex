module Poloniex
  class History < BasePoloniex
    attr_reader :order_number, :global_trade_id, :trade_id, :type, :rate, :amount, :total, :date, :margin, :fee, :category, :raw, :error

    def initialize(attrs = {})
      @order_number = attrs['orderNumber']
      @global_trade_id = attrs['globalTradeID'].to_s
      @trade_id = attrs['tradeID']
      @type = attrs['type']
      @rate = attrs['rate']
      @amount = attrs['amount']
      @total = attrs['total']
      @date = attrs['date']
      @fee = attrs['fee']
      @category = attrs['category']
      @error = attrs['error']
      @raw = attrs
    end

    def self.all
      response = client.post('returnTradeHistory', currencyPair: 'all')
      response.each_with_object({}){ |key, hsh| hsh[key.first] = key.second.map{ |e| new(e) } }
    end

    def self.all_for(pair)
      client.post('returnTradeHistory', currencyPair: normalize_pair(pair)).map{ |e| new(e) }
    end

    def self.by_order_number(order_number)
      all.map{ |key, value| value }.flatten.detect{ |order| order.order_number == order_number }
    end
  end
end