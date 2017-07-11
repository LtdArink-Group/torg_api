module TorgApi
  module Api
    # Справочник кодов ОКВЭД
    class Okved < TorgApi::Base
      # @param id [Integer] id okved

      # @return [Integer] id
      attr_accessor :id
      # @return [Integer] Полное наименование
      attr_accessor :fullname
      # @return [Integer] Наименование
      attr_accessor :title
      # @return [Integer] Код
      attr_accessor :code

      class << self
        def find(id)
          responce = JSON.parse(
            torg_resource["okveds/show"].get(
              params: { id: id },
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )
          okved = new(responce[:okved])
        end

      end
    end
  end
end
