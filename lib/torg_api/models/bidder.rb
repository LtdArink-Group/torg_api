module TorgApi
  module Models
    class Bidder < ActiveRecord::Base
      has_many :bidder_files

      def to_api
        bidder = TorgApi::Api::Bidder.new
        bidder.id = id
        bidder.contractor_id = contractor_id
        bidder.tender_id = tender_id

        bidder
      end
    end
  end
end
