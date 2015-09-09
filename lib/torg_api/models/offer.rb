module TorgApi
  module Models
    # TORG Offer model
    class Offer < TorgDatabase
      has_many :offer_specifications

      def self.for_bid_lot_num(bidder_id, lot_id, num)
        where(bidder_id: bidder_id).where(lot_id: lot_id).where(num: num).where(version: 0).take
      end
    end
  end
end
