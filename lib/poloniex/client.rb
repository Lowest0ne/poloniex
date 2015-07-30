require 'rest-client'
require 'openssl'
require 'addressable/uri'


module Poloniex
  class Client
    attr_reader :key, :secret

    def initialize(attrs = {})
      @key    = attrs[:key]
      @secret = attrs[:secret]
    end

    def get( command, params = {} )
      params[:command] = command
      response = resource[ 'public' ].get params: params
      prepare_response(response)
    end

    def post( command, params = {} )
      params[:command] = command
      params[:nonce]   = Time.now.to_i * 1000
      response = resource[ 'tradingApi' ].post params, { Key: key , Sign: create_sign( params ) }
      prepare_response(response)
    end

    private

    def prepare_response(response)
      data = response.present? ?
        JSON.parse(response) :
        raise('No response from API')
      data.is_a?(Hash) && data['error'].present? ? [data] : data
    end

    def resource
      @@resouce ||= RestClient::Resource.new( 'https://www.poloniex.com' )
    end

    def create_sign( data )
      encoded_data = Addressable::URI.form_encode( data )
      OpenSSL::HMAC.hexdigest( 'sha512', secret , encoded_data )
    end
  end
end
