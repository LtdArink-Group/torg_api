module TorgApi
  module Api
    # Комиссия
    class Commission < TorgApi::Base

      # @return [Integer] id
      attr_accessor :id

      # @return [String] Наименование комиссии
      attr_accessor :name

      # @return [String] Наименование комиссии, родительный падеж
      attr_accessor :name_r

      # @return [Integer] id подразделения
      attr_accessor :department_id

      # @return [Integer] id типа комиссии
      attr_accessor :commission_type_id

      # @return [Boolean] Актуальность
      attr_accessor :is_actual

      # @return [Boolean] Может проводить закупки для сторонних заказчиков
      attr_accessor :for_customers

      # @return [Array] Члены комиссии
      attr_accessor :commission_users

      class << self
        # Поиск коммиссии по id
        # @param commission_id [Integer] id комиссии
        # @return [Commission] возвращает объект комиссии
        def find(commission_id)
          responce = JSON.parse(
            torg_resource["/commissions/#{commission_id}"].get(
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )
          new(responce[:commission])
        end
      end
    end
  end
end
