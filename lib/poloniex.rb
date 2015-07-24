require 'poloniex/version'

module Poloniex
  autoload :Client,           'poloniex/client'
  autoload :Configuration,    'poloniex/configuration'
  autoload :Wallet,           'poloniex/wallet'
  autoload :Market,           'poloniex/market'
  autoload :OrderBook,        'poloniex/order_book'
  autoload :Withdrawal,       'poloniex/withdrawal'
  autoload :Withdraw,         'poloniex/withdraw'
  autoload :Deposit,          'poloniex/deposit'
  autoload :DepositWithdrawal,'poloniex/deposit_withdrawal'
  autoload :BasePoloniex,     'poloniex/base_poloniex'
  autoload :BaseTransaction,  'poloniex/base_transaction'
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
