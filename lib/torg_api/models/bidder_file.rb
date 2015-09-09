module TorgApi
  module Models
    class BidderFile < TorgDatabase
      belongs_to :tender_file

      def self.file_exists?(file_name)
        joins(:tender_file).where(tender_files: { external_filename: file_name }).exists?
      end
    end
  end
end
