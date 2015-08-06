module Poloniex
  class History < BasePoloniex
    attr_reader :order_number, :global_trade_id, :trade_id, :type, :rate, :amount, :total, :date, :margin, :fee, :category, :raw, :error, :fee_percent

    def initialize(attrs = {})
      @order_number = attrs['orderNumber']
      @global_trade_id = attrs['globalTradeID'].to_s
      @trade_id = attrs['tradeID']
      @type = attrs['type']
      @rate = attrs['rate']
      @amount = calculate_amount(attrs)
      @total = calculate_total(attrs)
      @date = attrs['date']
      @fee_percent = attrs['fee']
      if @total && @amount
        @fee = calculate_fee
        fix_total
      end
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

    private

    def fix_total
      @total = (BigDecimal.new(@total) - BigDecimal.new(@fee)).to_s
    end

    def calculate_total(attrs = {})
      sell_order? ?  attrs['total'] : attrs['amount']
    end

    def calculate_amount(attrs = {})
      sell_order? ? attrs['amount'] : attrs['total']
    end

    def sell_order?
      @type == 'sell'
    end

    def calculate_fee
      (BigDecimal.new(@fee_percent) * BigDecimal.new(@total)).to_s
    end
  end
end