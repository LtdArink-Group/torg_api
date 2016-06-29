module TorgApi
  module Api
    # Закупка
    class Tender < TorgApi::Base
      # @return [Integer] id
      attr_accessor :id
      # @return [String] Номер
      attr_accessor :num
      # @return [String] Наименование
      attr_accessor :name
      # @return [Integer] id способа закупки
      attr_accessor :tender_type_id
      # @return [String] Наименование способа закупки
      attr_accessor :tender_type_name
      # @return [String] Обоснование выбора способа
      attr_accessor :tender_type_explanations
      # @return [Integer] Адрес ЭТП
      attr_accessor :etp_address_id
      # @return [Integer] Закупочная комиссия
      attr_accessor :commission_id
      # @return [Integer] Организатор
      attr_accessor :department_id
      # @return [Date] Дата публикации в СМИ
      attr_accessor :announce_date
      # @return [String] Место публикации
      attr_accessor :announce_place
      # @return [Time] Дата вскрытия конвертов
      attr_accessor :bid_date
      # @return [String] Место вскрытия конвертов
      attr_accessor :bid_place
      # @return [Integer] Ответственный пользователь
      attr_accessor :user_id
      # @return [String] Email пользователя
      attr_accessor :user_email
      # @return [Integer] Номер закупки на ООС
      attr_accessor :oos_num
      # @return [Integer] Идентификатор закупки на ООС
      attr_accessor :oos_id
      # @return [Integer] Номер закупки на ЭТП
      attr_accessor :etp_num
      # @return [String] № распоряжения
      attr_accessor :order_num
      # @return [Date] Дата распоряжения
      attr_accessor :order_date
      # @return [Integer] Контактные данные организатора
      attr_accessor :contact_id
      # @return [String] Место утверждения документации
      attr_accessor :confirm_place
      # @return [Integer] Срок предоставления запросов на разъяснение (дней до вскрытия)
      attr_accessor :explanation_period
      # @return [Integer] Количество копий заявок/предложений на бумажном носителе
      attr_accessor :paper_copies
      # @return [Integer] Количество копий заявок/предложений в электронном виде
      attr_accessor :digit_copies
      # @return [Integer] Срок действия конкурсной заявки
      attr_accessor :life_offer
      # @return [Date] Дата начала приёма заявок/предложений
      attr_accessor :offer_reception_start
      # @return [Date] Дата окончания приёма заявок/предложений
      attr_accessor :offer_reception_stop
      # @return [String] Место рассмотрения заявок/предложений
      attr_accessor :review_place
      # @return [Time] Дата рассмотрения заявок/предложений
      attr_accessor :review_date
      # @return [String] Место подведения итогов
      attr_accessor :summary_place
      # @return [Time] Дата подведения итогов
      attr_accessor :summary_date
      # @return [Boolean] Учитывается/не учитывается добровольная сертификация
      attr_accessor :is_sertification
      # @return [Boolean] Требуется/не требуется обеспечение заявок
      attr_accessor :is_guarantie
      # @return [String] Форма обеспечения заявок
      attr_accessor :guarantie_offer
      # @return [Date] Срок обеспечения (дата начала)
      attr_accessor :guarantie_date_begin
      # @return [Date] Срок обеспечения (дата окончания)
      attr_accessor :guarantie_date_end
      # @return [String] Порядок внечения денежных средств
      attr_accessor :guarantie_making_money
      # @return [String] Реквизиты для перечисления
      attr_accessor :guarantie_recvisits
      # @return [String] Требования к гаранту
      attr_accessor :guarant_criterions
      # @return [Boolean] Допускаются/не допускаются коллективные участники
      attr_accessor :is_multipart
      # @return [Integer] Количество альтернативных предложений
      attr_accessor :alternate_offer
      # @return [String] Аспекты по которым может быть подано альтернативное предложение
      attr_accessor :alternate_offer_aspects
      # @return [String] Срок оплаты
      attr_accessor :maturity
      # @return [Boolean] Допускается/не допускается авансирование
      attr_accessor :is_prepayment
      # @return [Decimal] Размер аванса руб
      attr_accessor :prepayment_cost
      # @return [Decimal] Размер аванса %
      attr_accessor :prepayment_percent
      # @return [String] Условия аванса
      attr_accessor :prepayment_aspects
      # @return [String] Срок оплаты аванса
      attr_accessor :prepayment_period_begin
      # @return [String] Срок оплаты оставшейся части
      attr_accessor :prepayment_period_end
      # @return [Integer] Вид проекта договора
      attr_accessor :project_type_id
      # @return [String] Текст проекта договора
      attr_accessor :project_text
      # @return [String] Порядок предоставления документации
      attr_accessor :provide_td
      # @return [String] Преференции
      attr_accessor :preferences
      # @return [String] Иные существенные условия
      attr_accessor :other_terms
      # @return [Integer] Срок заключения договора
      attr_accessor :contract_period
      # @return [String] Порядок подготовки заявок/предложений
      attr_accessor :prepare_offer
      # @return [String] Порядок предоставления заявок/предложений
      attr_accessor :provide_offer
      # @return [Boolean] Право участвовать генеральным подрядчикам
      attr_accessor :is_gencontractor
      # @return [String] Обеспечение исполнения обязательств по договору
      attr_accessor :contract_guarantie
      # @return [Boolean] Простая продукция
      attr_accessor :is_simple_production
      # @return [String] Причины внесения изменений
      attr_accessor :reason_for_replace
      # @return [Boolean] Переторжка предусмотрена/не предусмотрена
      attr_accessor :is_rebid
      # @return [Integer] Срок отказа от проведения конкурса
      attr_accessor :failure_period
      # @return [String] Место предоставления конвертов
      attr_accessor :offer_reception_place
      # @return [Integer] Часовой пояс проведения закупки
      attr_accessor :local_time_zone_id
      # Поиск участника по его идентификатору в справочнике
      # @param contractor_id [Integer] Идентификатор котрагента в справочнике
      # return [Bidder] возвращает объект участника
      def find_bidder(contractor_id)
        responce = JSON.parse(
          torg_resource["tenders/#{id}/bidders"].get(
              accept: :json,
              content_type: :json,
              format: :json
          )
        )
        bidder = responce.select { |value| value['contractor_id'] == contractor_id }
        bidder[0]
      end

      def find_lot(num)
        Lot.find(id, num)
      end

      class << self
        # Поиск закупки по id
        # @param id [Integer] id закупки
        # @return [Tender] возвращает объект закупки
        def find(id)
          responce = JSON.parse(
            torg_resource["tenders/#{id}"].get(
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )

          t = Tender.new
          t.id = responce[:id]
          t.num = responce[:num]
          t.name = responce[:name]
          t.tender_type_id = responce[:tender_type_id]
          t.tender_type_explanations = responce[:tender_type_explanations]
          t.etp_address_id = responce[:etp_address_id]
          t.commission_id = responce[:commission_id]
          t.department_id = responce[:department_id]
          t.announce_date = responce[:announce_date]
          t.announce_place = responce[:announce_place]
          t.bid_date = responce[:bid_date]
          t.bid_place = responce[:bid_place]
          t.user_id = responce[:user_id]
          t.oos_num = responce[:oos_num]
          t.oos_id = responce[:oos_id]
          t.etp_num = responce[:etp_num]
          t.order_num = responce[:order_num]
          t.order_date = responce[:order_date]
          t.contact_id = responce[:contact_id]
          t.confirm_place = responce[:confirm_place]
          t
        end
      end
    end
  end
end
