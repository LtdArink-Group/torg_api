module TorgApi
  module Api
    # Участник закупки
    class Bidder < TorgApi::Base
      # @return [Integer] id
      attr_accessor :id
      # @return [Integer] ID участника
      attr_accessor :contractor_id
      # @return [Integer] ID закупки
      attr_accessor :tender_id

      class << self
        # Создаёт участника в системе и возвращает его id
        # @param contractor_id [Integer] id контрагента
        # @param tender_id [Integer] id закупки
        # @param date_offer [Time] Дата и время регистрации конверта участника
        # @return [Bidder]

        def create(contractor_id, tender_id, date_offer = nil)
          responce_b = JSON.parse(
            RestClient.post(
              [Settings.torg_url[:host], "tenders", tender_id, "bidders"].join('/'),
              bidder: {
                tender_id: tender_id,
                contractor_id: contractor_id,
                covers_attributes: {
                  '0' => {
                    _destroy: false,
                    compound_register_time_attributes: {
                      date: date_offer && date_offer.strftime('%d.%m.%Y'),
                      time: date_offer && date_offer.strftime('%H:%M')
                    },
                    type_id: CoverLabels::REQUEST,
                    delegate: 'B2B-Center',
                    provision: 'Электронный конверт'
                  }
                }
              },
              accept: :json,
              content_type: :json,
              format: :json
            ),
            symbolize_names: true
          )

          b = new
          b.tender_id = responce_b[:tender_id]
          b.contractor_id = responce_b[:contractor_id]
          b.id = responce_b[:id]
          b
        end
      end
      # Проверяет, есть ли файл с таким именем у данного участника
      # @param file_name [String] Имя файла во внешней системе
      # return [Boolean]
      def file_exists?(file_name)
        responce = JSON.parse(
          RestClient.get(
            [Settings.torg_url[:host], "tenders", tender_id, "bidders", id, "file_exists"].join('/'),
              params: { file_name: file_name },
              accept: :json,
              content_type: :json,
              format: :json
          ),
          symbolize_names: true
        )
        responce[:exists]
      end

      # Добавляет файл предложения участника к нему
      # @param file [String] имя файла и путь к нему
      # @param name [String] имя файла во внешней системе
      # @param note [String] Комментарии
      # @return Nothing
      def add_file(file, name = nil, note = nil)
        document = if file.start_with?('http')
          { remote_document_url: file }
        else
          { document: File.open(file) }
        end
        responce_f = JSON.parse(
          RestClient.post(
            [Settings.torg_url[:host], "tender_files"].join('/'),
            tender_file: {
              area_id: TenderFileArea::BIDDER,
              year: Date.current.year,
              external_filename: name
            }.merge(document),
            accept: :json,
            content_type: :json,
            format: :json
          ),
          symbolize_names: true
        )

        responce_bf = JSON.parse(
          RestClient.patch(
            [Settings.torg_url[:host], "tenders", tender_id, "bidders", id].join('/'),
            bidder: {
              bidder_files_attributes: {
                '0' => {
                  note: note,
                  tender_file_id: responce_f[:id],
                  bidder_id: id
                }
              }
            },
            accept: :json,
            content_type: :json,
            format: :json
          ),
          symbolize_names: true
        )
        responce_bf
      end
    end
  end
end
