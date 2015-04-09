module TorgApi
  module Api
    # Участник закупки
    class Bidder < TorgApi::Base
      class << self
        # Создаёт участника в системе и возвращает его id
        # @param contractor_id [Integer] id контрагента
        # @param tender_id [Integer] id закупки
        # @param date_offer [Time] Дата и время регистрации конверта участника
        # @return [Integer]
        def create(contractor_id, tender_id, date_offer = nil)
          b = nil
          TorgApi::Models::Bidder.transaction do
            b = TorgApi::Models::Bidder.create!(
              tender_id: tender_id,
              contractor_id: contractor_id
            )

            TorgApi::Models::Cover.create!(
              bidder_id: b.id,
              register_time: date_offer,
              type_id: CoverLabels::REQUEST,
              delegate: 'B2B-Center',
              provision: 'Электронный конверт'
            )
          end

          b.id
        end
      end
    end
  end
end
