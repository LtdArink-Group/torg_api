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

        def save(bidder_id, lot_id, hash)
          offer = TorgApi::Models::Offer.for_bid_lot_num(bidder_id, lot_id, hash[:alternate_num]) ||
                  TorgApi::Models::Offer.new(bidder_id: bidder_id, lot_id: lot_id, num: hash[:alternate_num], version: 0)
          TorgApi::Models::Offer.transaction do
            offer.type_id = CoverLabels::REQUEST
            offer.status_id = hash[:result] == 'reject' ? OfferStatuses::REJECT : OfferStatuses::NEW
            offer.rank = hash[:rank]
            offer.conditions = hash[:essential]

            TorgApi::Models::Specification.where(lot_id: lot_id).each_with_index do |spec, index|
              offer_spec = offer.offer_specifications.for_offer_spec(offer.id, spec.id) ||
                           offer.offer_specifications.build(specification_id: spec.id)
              offer_spec.cost = index == 0 ? hash[:price_notax] : 0
              offer_spec.cost_nds = index == 0 ? hash[:price] : 0
              offer_spec.final_cost = index == 0 ? hash[:final_price_notax] : 0
              offer_spec.final_cost_nds = index == 0 ? hash[:final_price] : 0
            end

            offer.save
          end

          offer.id
        end

        def extract_status(winner)
          winner ? OfferStatuses::WIN : OfferStatuses::NEW
        end
      end
    end
  end
end
