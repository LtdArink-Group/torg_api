module TorgApi
  module Api
    # Адреса (ФИАС) системы ТОРГ
    class Fias < TorgApi::Base
      # @param id [Integer] id user

      # @return [Integer] id
      attr_accessor :id
      # @return [Guid] Guid адреса
      attr_accessor :aoid
      # @return [Guid] Guid дома
      attr_accessor :houseid
      # @return [String] Адрес
      attr_accessor :name
      # @return [Integer] Код региона
      attr_accessor :regioncode
      # @return [Integer] Почтовый код
      attr_accessor :postalcode
      # @return [Integer] ОКАТО
      attr_accessor :okato
      # @return [Integer] ОКТМО
      attr_accessor :oktmo

      class << self
        def find(id)
          responce = JSON.parse(
            torg_resource["fias/#{id}"].get(
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )
          new(responce)
        end
      end
    end
  end
end
