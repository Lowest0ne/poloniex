module Poloniex
  class Currency < BasePoloniex
    # "1CR", {"name"=>"1CRedit", "maxDailyWithdrawal"=>"10000.00000000", "txFee"=>"0.01000000", "minConf"=>3, "disabled"=>0, "delisted"=>0}]

    attr_reader :name, :full_name, :max_daily_withdrawal, :fee, :min_conf, :disabled, :delisted, :raw

    def initialize(attrs = {})
      @name = attrs.first
      @full_name = attrs.last['name']
      @max_daily_withdrawal = attrs.last['maxDailyWithdrawal']
      @fee = attrs.last['txFee']
      @min_conf = attrs.last['minConf']
      @disabled = attrs.last['disabled']
      @delisted = attrs.last['delisted']
      @raw = attrs
    end

    def self.all
      response = client.get('returnCurrencies')
      response.map{ |e| new(e) } if response.present?
    end

    def self.by_name(currency)
      all.detect{ |e| e.name == currency }
    end
  end
end