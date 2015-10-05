module Poloniex
  class BaseTransaction < BasePoloniex
    TIME_SHIFTS = {
      big: 1.month,
      small: 1.minute,
      default: 10.minute
    }

    def self.by_txid(txid)
      all.detect{ |e| e.txid == txid }
    end

    def self.last_bunch_for_short_period
      all(Time.now - TIME_SHIFTS[:big], Time.now)
    end

    def self.last_bunch_for_short_period_by_address(address)
      last_bunch_for_short_period.map { |e| e if e.address == address }
    end

    def self.by_destination(address)
      all.map{ |e| e if e.address == address }
    end
  end
end