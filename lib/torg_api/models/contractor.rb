module TorgApi
  module Models
    class Contractor < TorgDatabase
      def to_api
        c = TorgApi::Api::Contractor.new
        c.id = id
        c.name = name
        c.fullname = fullname
        c.ownership = ownership
        c.inn = inn
        c.kpp = kpp
        c.ogrn = ogrn
        c.okpo = okpo
        c.status = status
        c.form = form
        c.legal_addr = legal_addr
        c.user_id = user_id
        c.is_resident = is_resident
        c.is_dzo = is_dzo
        c.is_sme = is_sme
        c.jsc_form_id = jsc_form_id
        c.sme_type_id = sme_type_id
        c
      end
    end
  end
end
