require 'poloniex/version'

module Poloniex
  autoload :Client,           'poloniex/client'
  autoload :Configuration,    'poloniex/configuration'
  autoload :Wallet,           'poloniex/wallet'
  autoload :Market,           'poloniex/market'
  autoload :MarketVolume,     'poloniex/market_volume'
  autoload :OrderBook,        'poloniex/order_book'
  autoload :Withdraw,         'poloniex/withdraw'
  autoload :Withdrawal,       'poloniex/transactions/withdrawal'
  autoload :Deposit,          'poloniex/transactions/deposit'
  autoload :Transaction,      'poloniex/transactions/transaction'
  autoload :BaseTransaction,  'poloniex/transactions/base_transaction'
  autoload :BasePoloniex,     'poloniex/base_poloniex'
  autoload :Currency,         'poloniex/currency'
  autoload :History,          'poloniex/history'
  autoload :Order,            'poloniex/order'
  autoload :Trade,            'poloniex/trade'

  def self.client
    @client ||= Client.new(configuration.auth)
  end

  def self.setup
    yield configuration
    @client = Client.new(configuration.auth)
  end

  def self.configuration
    Configuration.instance
  end

  def self.root
    File.expand_path('../..', __FILE__)
  end
end
