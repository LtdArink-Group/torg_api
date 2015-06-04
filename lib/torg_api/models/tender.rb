module TorgApi
  module Models
    class Tender < ActiveRecord::Base
      def to_api
        t = TorgApi::Api::Tender.new
        t.id = id
        t.num = num
        t.name = name
        t.tender_type_id = tender_type_id
        t.tender_type_explanations = tender_type_explanations
        t.etp_address_id = etp_address_id
        t.commission_id = commission_id
        t.department_id = department_id
        t.announce_date = announce_date
        t.announce_place = announce_place
        t.bid_date = bid_date
        t.bid_place = bid_place
        t.user_id = user_id
        t.oos_num = oos_num
        t.oos_id = oos_id
        t.etp_num = etp_num
        t.order_num = order_num
        t.order_date = order_date
        t.contact_id = contact_id
        t.confirm_place = confirm_place
        t
      end
    end
  end
end
