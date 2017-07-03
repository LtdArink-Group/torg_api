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
                status_id: OfferStatuses::NEW,
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

        def find(tender_id, bidder_id, lot_id, offer_num, spec_id)
          responce = JSON.parse(
            torg_resource["tenders/#{tender_id}/bidders/#{bidder_id}/offers"].get(
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )
          offer = responce.select { |value|
            value[:lot_id] == lot_id &&
            value[:num] == offer_num &&
            value[:offer_specifications][0][:offer_specification][:specification_id] == spec_id
          }
          offer
        end

      end
    end
  end
end
