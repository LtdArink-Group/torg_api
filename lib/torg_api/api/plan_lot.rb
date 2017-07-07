module TorgApi
  module Api
    # Планирование
    class PlanLot < TorgApi::Base
      # @return [Integer] id
      attr_accessor :id

      # ГУИД лота
      # @return [String]]
      attr_accessor :guid

      # Версия записи (0 - текущая)
      # @return [Integer]
      attr_accessor :version

      # Год ГКПЗ
      # @return [Integer]
      attr_accessor :gkpz_year

      # Номер закупки
      # @return [Integer]
      attr_accessor :num_tender

      # Номер лота
      # @return [Integer]
      attr_accessor :num_lot

      # Наименование лота
      # @return [String]
      attr_accessor :lot_name

      # ИД организатора
      # @return [Integer]
      attr_accessor :department_id

      # ИД способа закупки
      # @return [Integer]
      attr_accessor :tender_type_id

      # Обоснование выбора способа закупки
      # @return [String]
      attr_accessor :tender_type_explanations

      # Предмет закупки
      # @return [Integer]
      attr_accessor :subject_type_id

      # ИД адреса ЭТП, на которой будет объявлена закупка
      # @return [Integer]
      attr_accessor :etp_address_id

      # Дата объявления
      # @return [Date]
      attr_accessor :announce_date

      # Обосновывающий док-т (только для ЕИ)
      # @return [String]
      attr_accessor :explanations_doc

      # Пункт положения
      # @return [String]
      attr_accessor :point_clause

      # ИД протокола
      # @return [Integer]
      attr_accessor :protocol_id

      # ИД статуса
      # @return [Integer]
      attr_accessor :status_id

      # ИД комиссии
      # @return [Integer]
      attr_accessor :commission_id

      # ИД пользователя
      # @return [Integer]
      attr_accessor :user_id

      # ИД рутового заказчика
      # @return [Integer]
      attr_accessor :root_customer_id

      # ГУИД основной закупки
      # @return [String]
      attr_accessor :additional_to

      # Состояние в ГКПЗ: 0 - внеплан, 1 - план
      # @return [Integer]
      attr_accessor :state

      # Отношение к участию субъектов малого и среднего предпринимательства
      # @return [Integer]
      attr_accessor :sme_type_id

      # Номер доп. соглашения
      # @return [Integer]
      attr_accessor :additional_num

      # Главное направление
      # @return [Integer]
      attr_accessor :main_direction_id

      # Типы закупок из постановления правительства №1352 от 11.12.2014
      # @return [Integer]
      attr_accessor :order1352_id

      # GUID закупки предварительного отбора
      # @return [String]
      attr_accessor :preselection_guid

      # Ссылка на пункт положения
      # @return [Integer]
      attr_accessor :regulation_item_id

      # Дата направления поручения
      # @return [Date]
      attr_accessor :charge_date

      # Протокол
      # @return [Hash]
      attr_accessor :protocol

      # Готовые лимиты
      # @return [Array]
      attr_accessor :plan_annual_limits

      # Спецификации
      # @return [Array]
      attr_accessor :plan_specifications

      # Планируемые участники
      # @return [Array]
      attr_accessor :plan_lot_contractors


      class << self
        # Поиск лота из планирования по id
        # @param plan_lot_id [Integer] id закупки
        # @return [PlanLot] возвращает объект лот планирования
        def find(plan_lot_id)
          responce = JSON.parse(
            torg_resource["plan_lots/#{plan_lot_id}"].get(
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )
          new(responce[:plan_lot])
        end
      end
    end
  end
end
