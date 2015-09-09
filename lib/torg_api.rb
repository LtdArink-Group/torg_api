require 'torg_api/settings'
require 'active_record'
require 'torg_api/version'
require 'torg_api/constants'
require 'torg_api/base'
require 'torg_api/api'

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

module TorgApi
  def self.logger=(logger)
    ActiveRecord::Base.logger = logger
  end
end
