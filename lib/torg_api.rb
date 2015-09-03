require 'active_record'
require 'torg_api/version'
require 'torg_api/constants'
require 'torg_api/base'
require 'torg_api/api'
require 'torg_api/settings'

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

module TorgApi
  def self.establish_connection(spec = nil)
    ActiveRecord::Base.establish_connection(spec)
  end

  def self.logger=(logger)
    ActiveRecord::Base.logger = logger
  end
end
