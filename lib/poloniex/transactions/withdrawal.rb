module Poloniex
  class Withdrawal < BaseTransaction
    # {"withdrawalNumber"=>658929
    #   "currency"=>"DOGE"
    #   "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC"
    #   "amount"=>"1.00000000"
    #   "timestamp"=>1437646234
    #   "status"=>"COMPLETE: ERROR"
    #   "ipAddress"=>"93.84.30.93"}
    # {"withdrawalNumber"=>659014
    #   "currency"=>"DOGE"
    #   "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC"
    #   "amount"=>"2.00000000"
    #   "timestamp"=>1437657296
    #   "status"=>"COMPLETE: fcf3ba132caffc844bcc849abb8467fa4a32b2210e9c8b95d050439bfa659fb4"
    #   "ipAddress"=>"93.84.30.93"}
    attr_reader :id, :currency, :address, :amount, :timestamp, :status, :ip, :txid, :raw

    def initialize(attrs = {})
      @id = attrs['withdrawalNumber'].to_s
      @currency = attrs['currency']
      @address = attrs['address']
      @amount = attrs['amount']
      @timestamp = attrs['timestamp']
      @ip = attrs['ip']
      @status, @txid = normalize_status(attrs['status'])
      @raw = attrs
    end

    def self.all(start_time = Time.now - TIME_SHIFTS[:big], end_time = Time.now)
      Transaction.all(start_time, end_time).withdrawals.map { |e| new(e) }
    end

    private

    def normalize_status(status)
      data = status.split(':')
      data[1].try(:strip) == 'ERROR' ?
        data[0] :
        [data[0], data[1].try(:strip)]
    end
  end
end