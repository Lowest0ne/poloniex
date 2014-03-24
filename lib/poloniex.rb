require "poloniex/version"

require 'rest-client'
require 'openssl'
require 'addressable/uri'

module Poloniex

  class << self
    attr_accessor :configuration
  end

  def self.setup
    @configuration ||= Configuration.new
    yield( configuration )
  end

  class Configuration
    attr_accessor :key, :secret

    def intialize
      @key    = ''
      @secret = ''
    end
  end

  def self.ticker
    get 'returnTicker'
  end

  def self.volume
    get 'return24hVolume'
  end

  def self.order_book( currency_pair )
    get 'returnOrderBook', currencyPair: currency_pair
  end

  def self.trade_history( currency_pair )
    get 'returnTradeHistory', currencyPair: currency_pair
  end

  def self.balances
    post 'returnBalances'
  end

  def self.open_orders( currency_pair )
    post 'returnOpenOrders', currencyPair: currency_pair
  end

  def self.trade_history( currency_pair )
    post 'returnTradeHistory', currencyPair: currency_pair
  end

  def self.buy( currency_pair, rate, amount )
    post 'buy', currencyPair: currency_pair, rate: rate, amount: amount
  end

  def self.sell( currency_pair, rate, amount )
    post 'sell', currencyPair: currency_pair, rate: rate, amount: amount
  end

  def self.cancel_order( currency_pair, order_number )
    post 'cancelOrder', currencyPair: currency_pair, orderNumber: order_number
  end

  def self.withdraw( curreny, amount, address )
    post 'widthdraw', currency: currency, amount: amount, address: address
  end

  protected

  def self.resource
    @@resouce ||= RestClient::Resource.new( 'https://www.poloniex.com' )
  end

  def self.get( command, params = {} )
    params[:command] = command
    resource[ 'public' ].get params: params
  end

  def self.post( command, params = {} )
    params[:command] = command
    params[:nonce]   = Time.now.to_i * 1000
    resource[ 'tradingApi' ].post params, { Key: configuration.key , Sign: create_sign( params ) }
  end

  def self.create_sign( data )
    encoded_data = Addressable::URI.form_encode( data )
    OpenSSL::HMAC.hexdigest( 'sha512', configuration.secret , encoded_data )
  end

end
