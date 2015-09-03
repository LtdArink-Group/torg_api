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
          b = nil
          TorgApi::Models::Bidder.transaction do
            b = TorgApi::Models::Bidder.create!(
              tender_id: tender_id,
              contractor_id: contractor_id
            )

            TorgApi::Models::Cover.create!(
              bidder_id: b.id,
              register_time: date_offer,
              type_id: CoverLabels::REQUEST,
              delegate: 'B2B-Center',
              provision: 'Электронный конверт'
            )
          end

          b.to_api
        end
      end

      # Проверяет, есть ли файл с таким именем у данного участника
      # @param file_name [String] Имя файла во внешней системе
      # return [Boolean]
      def file_exists?(file_name)
        bidder = TorgApi::Models::Bidder.find(id)
        bidder.bidder_files.file_exists?(file_name)
      end

      # Добавляет файл предложения участника к нему
      # @param file [String] имя файла и путь к нему
      # @param name [String] имя файла во внешней системе
      # @param note [String] Комментарии
      # @return Nothing
      def add_file(file, name = nil, note = nil)
        TorgApi::Models::BidderFile.transaction do
          tender_file = TorgApi::Models::TenderFile.create(
            area_id: TenderFileArea::BIDDER,
            year: Date.current.year,
            document: File.open(file),
            user_id: Settings.service_user[:id],
            external_filename: name
          )
          TorgApi::Models::BidderFile.create!(
            bidder_id: id,
            tender_file_id: tender_file.id,
            note: note
          )
        end
      end
    end
  end
end
