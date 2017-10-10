module TorgApi
  module Api
    # Протокол вскрытия
    class OpenProtocol < TorgApi::Base
      # @return [Integer] id
      attr_accessor :id

      # @return [Integer] ID закупки
      attr_accessor :tender_id

      # @return [Integer] ID секретаря
      attr_accessor :clerk_id

      # @return [String] Место проведения
      attr_accessor :location

      # @return [Integer] Номер протокола
      attr_accessor :num

      # @return [String] Дата составления протокола
      attr_accessor :open_date

      # @return [String] Решение комиссии
      attr_accessor :resolve

      # @return [String] Город
      attr_accessor :sign_city

      # @return [String] Дата подписания протокола
      attr_accessor :sign_date

      # @return [Integer] ID комиссии
      attr_accessor :commission_id,

      class << self
        # Создает протокол вскрытия в системе
        # @param tender_id [Integer] id закупки
        # @param params [Hash] Параметры протокола вскрытия B2B-Center
        # @return [OpenProtocol]
        def create(tender_id, params)
          responce = JSON.parse(
            torg_resource["tenders/#{tender_id}/open_protocols"].post(
              open_protocol: {
                tender_id: tender_id,
                num: params[:number],
                open_date: params[:procedure_stage_date],
                sign_city: params[:place],
                sign_date: params[:sign_protocol_date],
                compound_open_date: params[:procedure_stage_date],
                compound_open_date_attributes: {
                  date: params[:procedure_stage_date].to_date,
                  time: params[:procedure_stage_date].strftime("%H:%M")
                },
                commission_id: params[:commission_id],
                resolve: params[:resolve],
                location: params[:location],
                clerk_id: params[:clerk_id]
              },
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
