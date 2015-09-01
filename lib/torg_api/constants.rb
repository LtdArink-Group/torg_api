module TorgApi
  module Constants
    module CoverLabels
      REQUEST = 22_001 # Заявка/Предложение
    end

    module OfferStatuses
      NEW = 26_001 # Первичная
      RECEIVE = 26_002 # Принята
      REJECT = 26_003 # Отклонена
      WIN = 26_004 # Победила
    end

    module TenderFileArea
      TENDER = 2
      BIDDER = 3
    end

    module EtpUsers
      B2B_CENTER = 411
    end
  end
end
