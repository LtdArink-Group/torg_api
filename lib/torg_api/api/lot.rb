module TorgApi
  module Api
    # Лот
    class Lot < TorgApi::Base
      # @return [Integer] id
      attr_accessor :id
      # @return [Integer] Номер
      attr_accessor :num

      class << self
        # Поиск закупки по id
        # @param id [Integer] id закупки
        # @return [Tender] возвращает объект закупки
        def find(tender_id, num)
          TorgApi::Models::Lot.where(tender_id: tender_id, num: num).take.to_api
        end
      end
    end
  end
end
