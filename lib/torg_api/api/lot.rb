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
          responce = JSON.parse(
            torg_resource["tenders/#{tender_id}"].get(
              accept: :json,
              content_type: :json,
              format: :json
            )
          )
          responce['lots'].select { |value| value['num'] == num }.first
        end
      end
    end
  end
end
