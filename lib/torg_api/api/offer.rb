module TorgApi
  module Api
    # Оферта участника
    class Offer < TorgApi::Base
      class << self
        # Создаёт оферту
        # @param lot_id [Integer] id лота
        # @param bidder_id [Integer] id участника
        # @param hash [Integer] хэш ответа веб-сервиса B2B
        # @return [Integer] id созданного объекта
        def create(lot_id, bidder_id, hash)
          o = nil
          TorgApi::Models::Offer.transaction do
            o = TorgApi::Models::Offer.create!(
              lot_id: lot_id,
              bidder_id: bidder_id,
              num: hash[:offer_num],
              version: 0,
              type_id: CoverLabels::REQUEST,
              status_id: extract_status(hash[:winner])
            )

            TorgApi::Models::Specification.where(lot_id: lot_id).each do |spec|
              TorgApi::Models::OfferSpecification.create!(
                offer_id: o.id,
                specification_id: spec.id,
                cost: hash[:final_price_notax],
                cost_nds: hash[:final_price],
                final_cost: hash[:final_price_notax],
                final_cost_nds: hash[:final_price]
              )
            end
          end

          o.id
        end

        def extract_status(winner)
          winner ? OfferStatuses::WIN : OfferStatuses::NEW
        end
      end
    end
  end
end
