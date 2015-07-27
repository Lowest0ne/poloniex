module Poloniex
  class Deposit < BaseTransaction
    # {"currency"=>"LTC", "address"=>"LXX5AN4MBi1j8o8EQHuYC7dEnumJjjKVX2", "amount"=>"0.02000000", "confirmations"=>3, "txid"=>"9b903a79efaf91077e77b8c5f733de2f64a173ca5777a8a6c32073957b414ec5", "timestamp"=>1437555610, "status"=>"COMPLETE"}
    attr_reader :currency, :address, :amount, :timestamp, :confirmations, :status, :ip, :txid, :raw

    def initialize(attrs = {})
      @currency = attrs['currency']
      @address = attrs['address']
      @amount = attrs['amount']
      @confirmations = attrs['confirmations']
      @txid = attrs['txid']
      @timestamp = attrs['timestamp']
      @status = attrs['status']
      @raw = attrs
    end

    def self.all(start_time = Time.now - TIME_SHIFTS[:big], end_time = Time.now)
      Transaction.all(start_time, end_time).deposits.map { |e| new(e) }
    end
  end
end