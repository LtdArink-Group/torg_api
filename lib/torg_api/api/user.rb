module TorgApi
  module Api
    # Пользователи системы ТОРГ
    class User < TorgApi::Base
      # @param id [Integer] id user

      # @return [Integer] id
      attr_accessor :id
      # @return [Integer] Электронная почта
      attr_accessor :email
      # @return [Integer] Фамилия
      attr_accessor :surname
      # @return [Integer] Имя
      attr_accessor :name
      # @return [Integer] Отчество
      attr_accessor :patronymic
      # @return [Integer] Должность
      attr_accessor :user_job
      # @return [Integer] Телефон рабочий
      attr_accessor :phone_public
      # @return [Integer] Телефон сотовый
      attr_accessor :phone_cell
      # @return [Integer] Факс
      attr_accessor :fax
      # @return [Integer] ID подразделения
      attr_accessor :department_id

      class << self
        def find(id)
          responce = JSON.parse(
            torg_resource["user/#{id}"].get(
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
