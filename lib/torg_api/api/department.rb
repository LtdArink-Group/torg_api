module TorgApi
  module Api
    # Подразделение заказчика в ТОРГ
    class Department < TorgApi::Base
      # @param id [Integer] id department

      # @return [Integer] id
      attr_accessor :id
      # @return [Integer] id подразделения верхнего уровня
      attr_accessor :parent_dept_id
      # @return [String] Наименование
      attr_accessor :name
      # @return [String] Юридический адрес
      attr_accessor :legal_address
      # @return [String] Фактический адрес
      attr_accessor :fact_address
      # @return [Boolean] Является заказчиком?
      attr_accessor :is_customer
      # @return [Boolean] Является организатором?
      attr_accessor :is_organizer
      # @return [Integer] id на ЭТП
      attr_accessor :etp_id
      # @return [String] Родословная
      attr_accessor :ancestry
      # @return [String] Полное наименование
      attr_accessor :fullname
      # @return [Integer] ИНН
      attr_accessor :inn
      # @return [Integer] КПП
      attr_accessor :kpp
      # @return [Integer] id формы собственности
      attr_accessor :ownership_id
      # @return [String] Краткое наименование
      attr_accessor :shortname
      # @return [Boolean] Является потребителем
      attr_accessor :is_consumer
      # @return [Numeric] Лимит по 223 ФЗ
      attr_accessor :eis223_limit
      # @return [Array] Форма собственности
      attr_accessor :ownership
      # @return [Array] Контактная информация
      attr_accessor :contact


      class << self
        def find(id)
          responce = JSON.parse(
            torg_resource["departments/#{id}"].get(
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )
          new(responce[:department])
        end
      end
    end
  end
end
