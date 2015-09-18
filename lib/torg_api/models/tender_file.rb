require 'torg_api/models/tender_file_uploader'
module TorgApi
  module Models
    class TenderFile < TorgDatabase
      mount_uploader :document, TenderFileUploader

      before_save :update_file_attributes

      private

      def update_file_attributes
        return unless document.present? || document_changed?
        self.content_type = document.file.content_type
        self.file_size = document.file.size
      end
    end
  end
end
