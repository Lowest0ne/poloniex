module Poloniex
  class DepositWithdrawal < BaseTransaction
    # {"deposits"=>[{"currency"=>"LTC", "address"=>"LXX5AN4MBi1j8o8EQHuYC7dEnumJjjKVX2", "amount"=>"0.02000000", "confirmations"=>3, "txid"=>"9b903a79efaf91077e77b8c5f733de2f64a173ca5777a8a6c32073957b414ec5", "timestamp"=>1437555610, "status"=>"COMPLETE"}, {"currency"=>"DOGE", "address"=>"DMfHiSrYxEipzDnkX2D8Y3dneemUvATdTN", "amount"=>"100.00000000", "confirmations"=>3, "txid"=>"fe3c97cdd1ad9fdd80e8ec0a22b94121070448df0a5ff8d1df21b6d633685734", "timestamp"=>1437555683, "status"=>"COMPLETE"}], "withdrawals"=>[{"withdrawalNumber"=>658929, "currency"=>"DOGE", "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC", "amount"=>"1.00000000", "timestamp"=>1437646234, "status"=>"COMPLETE: ERROR", "ipAddress"=>"93.84.30.93"}, {"withdrawalNumber"=>658935, "currency"=>"DOGE", "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC", "amount"=>"1.00000000", "timestamp"=>1437647082, "status"=>"COMPLETE: ERROR", "ipAddress"=>"93.84.30.93"}, {"withdrawalNumber"=>658973, "currency"=>"DOGE", "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC", "amount"=>"1.00000000", "timestamp"=>1437652345, "status"=>"COMPLETE: ERROR", "ipAddress"=>"93.84.30.93"}, {"withdrawalNumber"=>658974, "currency"=>"DOGE", "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC", "amount"=>"2.00000000", "timestamp"=>1437652354, "status"=>"COMPLETE: 0774d861de15cd3e29b7b84e636ec0e255fb4f186a157a4d6428f98bc2193e3d", "ipAddress"=>"93.84.30.93"}, {"withdrawalNumber"=>659004, "currency"=>"DOGE", "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC", "amount"=>"2.00000000", "timestamp"=>1437656596, "status"=>"COMPLETE: fb9917633cfa99001688c759f9a224f890c3f82e74477941c87d0d1e201213fa", "ipAddress"=>"93.84.30.93"}, {"withdrawalNumber"=>659005, "currency"=>"DOGE", "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC", "amount"=>"2.00000000", "timestamp"=>1437656669, "status"=>"COMPLETE: ebd8291988c734c3273f7b8a8408bf395193b8c0805f4552a52cdb211492e11e", "ipAddress"=>"93.84.30.93"}, {"withdrawalNumber"=>659011, "currency"=>"DOGE", "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC", "amount"=>"2.00000000", "timestamp"=>1437657126, "status"=>"COMPLETE: 18d04afa76857c22d7f554e54468fb6201f809780744960b820644506f3a237d", "ipAddress"=>"93.84.30.93"}, {"withdrawalNumber"=>659013, "currency"=>"DOGE", "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC", "amount"=>"2.00000000", "timestamp"=>1437657241, "status"=>"COMPLETE: 893507c408965f25949c70c5bacca190631cebe8c4bf9b6425715b963f306109", "ipAddress"=>"93.84.30.93"}, {"withdrawalNumber"=>659014, "currency"=>"DOGE", "address"=>"DFiJc8D7AGahyN3ZR87tkUjPrXrEr2hgXC", "amount"=>"2.00000000", "timestamp"=>1437657296, "status"=>"COMPLETE: fcf3ba132caffc844bcc849abb8467fa4a32b2210e9c8b95d050439bfa659fb4", "ipAddress"=>"93.84.30.93"}]}

    attr_reader :deposits, :withdrawals, :raw

    def initialize(attrs = {})
      @deposits = attrs['deposits']
      @withdrawals = attrs['withdrawals']
      @raw = attrs
    end

    def self.all(start_time = Time.now - TIME_SHIFTS[:big], end_time = Time.now)
      response = client.post('returnDepositsWithdrawals', start: start_time.to_i, end: end_time.to_i)
      new(response) if response.present?
    end
  end
end