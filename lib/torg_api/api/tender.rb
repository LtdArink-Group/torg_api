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
      # @return [String] Полное наименование способа закупки
      attr_accessor :tender_type_fullname
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
      attr_accessor :b2b_classifiers
      # @return [integer] Классификатор B2B-Center
      attr_accessor :local_time_zone_id
      # @return [Array] Лоты
      attr_accessor :lots
      # @return [Array] Файлы
      attr_accessor :link_tender_files
      # Поиск участника по его идентификатору в справочнике
      # @param contractor_id [Integer] Идентификатор котрагента в справочнике
      # return [Bidder] возвращает объект участника
      def find_bidder(contractor_id)
        responce = JSON.parse(
          TorgApi::Base.torg_resource["tenders/#{id}/bidders"].get(
              accept: :json,
              content_type: :json,
              format: :json
          ),
          symbolize_names: true
        )
        bidder = responce.select { |value| value[:contractor_id] == contractor_id }[0]
        Bidder.new(bidder) if bidder
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

          new(responce)
        end

        def update_etp_num(tender_id, etp_num)
          responce = JSON.parse(
            torg_resource["tenders/#{tender_id}"].patch(
              tender: {
                etp_num: etp_num
              },
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )
          new(responce)
        end

        # Поиск закупки по guid запланированного лота
        # @param guid [Guid] guid запланированного лота
        # @return [Tender] возвращает объект закупки
        def find_by_guid(guid)
          responce = JSON.parse(
            torg_resource["tenders?tender_filter[plan_lot_guids=#{guid}"].get(
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )
        end
      end
    end
  end
end
