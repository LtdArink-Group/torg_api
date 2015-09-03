module TorgApi
  module Api
    # Файл
    class TenderFile < TorgApi::Base
      # @return [Integer] id
      attr_accessor :id
      # @return [Integer] Область использования
      attr_accessor :area_id
      # @return [Integer] Год
      attr_accessor :year
      # @return [String] Имя файла документа
      attr_accessor :document
      # @return [Integer] Владелец
      attr_accessor :user_id
      # @return [String] Имя файла во внешних системах
      attr_accessor :external_filename
      # @return [String] Content Type
      attr_accessor :content_type
      # @return [Integer] FileSize
      attr_accessor :file_size
      class << self
        def create_from_b2b(hash, area, file_size)
          mime_types = MIME::Types.type_for(hash[:name])
          file = TenderFile.new
          file.area_id = area
          file.year = Date.current.year
          file.document = hash[:title]
          file.user_id = Settings.service_user[:id]
          file.external_filename = hash[:name]
          file.content_type = mime_types.empty? ? 'text/plain' : mime_types.first.content_type
          file.file_size = file_size

          TorgApi::Models::TenderFile.create!(file.to_h).id
        end
      end
    end
  end
end
