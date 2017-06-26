module TorgApi
  module Api
    # Оферта участника
    class Offer < TorgApi::Base
      # Создаёт оферту
      # @param lot_id [Integer] id лота
      # @param bidder_id [Integer] id участника
      # @param hash [Integer] хэш ответа веб-сервиса B2B

      # @return [Integer] id созданного объекта
      attr_accessor :id
      # @return [Integer] id лота
      attr_accessor :lot_id
      # @return [Integer] id участника
      attr_accessor :bidder_id
      # @return [String] номер оферты
      attr_accessor :num
      # @return [Integer] версия
      attr_accessor :version
      # @return [Integer] id типа оферты
      attr_accessor :type_id
      # @return [Integer] id статуса
      attr_accessor :status_id
      # @return [Array] Спецификация оферты
      attr_accessor :offer_specifications

      class << self
        def create(lot_id, bidder_id, hash, torg_spec_id, tender_id)
          responce_o = JSON.parse(
            torg_resource["tenders/#{tender_id}/bidders/#{bidder_id}/offers"].post(
              offer: {
                lot_id: lot_id,
                bidder_id: bidder_id,
                num: hash[:num],
                version: 0,
                type_id: CoverLabels::REQUEST,
                status_id: extract_status(hash[:status_id]),
                offer_specifications_attributes: {
                  '0' => {
                    specification_id: torg_spec_id,
                    cost: hash[:cost],
                    cost_nds: hash[:cost_nds],
                    final_cost: hash[:cost],
                    final_cost_nds: hash[:cost_nds]
                  }
                }
              },
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )
          new(responce_o)
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
