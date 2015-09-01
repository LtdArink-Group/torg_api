module TorgApi
  module Models
    class OfferSpecification < ActiveRecord::Base
      def self.for_offer_spec(offer_id, spec_id)
        where(offer_id: offer_id).where(specification_id: spec_id).take
      end
    end
  end
end
