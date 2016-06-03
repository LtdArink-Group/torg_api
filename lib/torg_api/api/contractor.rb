module TorgApi
  module Api
    # Контрагент
    class Contractor < TorgApi::Base
      # Порядок сортировки по значению поля status
      # enum status: { orig: 0, active: 1, old: 2, inactive: 3 }
      STATUS_ORDER = [1, 0, 3, 2]

      STATUS_ORDER_NUMS = [].tap do |mas|
        STATUS_ORDER.each_with_index { |o, i| mas << [o, i] }
      end.flatten.join(', ')

      DECODE_STATUS_ORDER = "decode(status, #{STATUS_ORDER_NUMS})"

      # @return [Integer] id контрагента
      attr_accessor :id
      # @return [String] Наименование
      attr_accessor :name
      # @return [String] Полное наименование
      attr_accessor :fullname
      # @return [String] Форма собственности
      attr_accessor :ownership
      # @return [String] ИНН
      attr_accessor :inn
      # @return [String] КПП
      attr_accessor :kpp
      # @return [String] ОГРН
      attr_accessor :ogrn
      # @return [String] ОКПО
      attr_accessor :okpo
      # @return [Integer] Статус записи(0-новая, 1-активная, 2-старая, 3-неактивная)
      attr_accessor :status
      # @return [Integer] Вид контрагента (0-ИП, 1-юр. лицо, 2-иностран., 3-физ. лицо)
      attr_accessor :form
      # @return [String] Юридический адрес
      attr_accessor :legal_addr
      # @return [Integer] ИД автора
      attr_accessor :user_id
      # @return [Boolean] Резидент?
      attr_accessor :is_resident
      # @return [Boolean] ДЗО?
      attr_accessor :is_dzo
      # @return [Boolean] Субъект малого и среднего предпринимательства?
      attr_accessor :is_sme
      # @return [Integer] Форма акционерного общества
      attr_accessor :jsc_form_id
      # @return [Integer] Малое или среднее предпринимательство
      attr_accessor :sme_type_id
      # @return [String] ОКТМО
      attr_accessor :oktmo
      # @return [String] Дата регистрации юр. лица
      attr_accessor :reg_date

      class << self
        # Поиск id контрагентов по ИНН
        # @param inn [String] ИНН
        # @return [Integer[]] Массив id найденных контрагентов отсортированных по статусу и дате изменения
        def find_by_inn(inn)
          responce = JSON.parse(
            RestClient.get(
              [Settings.torg_url[:host], "contractors", "find_by_inn"].join('/'),
                params: { inn: inn },
                accept: :json,
                content_type: :json,
                format: :json
            ),
            symbolize_names: true
          )

          c = new
          c.name = responce[:name]
          c.fullname = responce[:fullname]
          c.ownership = responce[:ownership]
          c.inn = responce[:inn]
          c.kpp = responce[:kpp]
          c.ogrn = responce[:ogrn]
          c.okpo = responce[:okpo]
          c.status = responce[:status]
          c.form = responce[:form]
          c.legal_addr = responce[:legal_addr]
          c.user_id = responce[:user_id]
          c.is_resident = responce[:is_resident]
          c.is_dzo = responce[:is_dzo]
          c.is_sme = responce[:is_sme]
          c.jsc_form_id = responce[:jsc_form_id]
          c.sme_type_id = responce[:sme_type_id]
          c.oktmo = responce[:oktmo]
          c.reg_date = responce[:reg_date]
          c
        end

        # Создаёт контрагента
        # @param hash [Hash] хэш ответа веб-сервиса B2B
        # @param user [Integer] id автора
        # @return Contractor
        def create_from_b2b(hash)
          c = Contractor.new
          c.name = hash[:org_name_short].gsub('"','')
          c.fullname = hash[:org_name]
          c.inn = hash[:bank_inn]
          c.kpp = hash[:bank_kpp]
          c.ogrn = hash[:ogrn]
          c.okpo = hash[:code_okpo]
          c.ownership = extract_ownership(hash[:org_name_short])
          c.status = 0
          c.form = extract_form(hash[:bank_inn])
          c.legal_addr = hash[:jury_address]
          c.user_id = Settings.service_user[:id]
          c.is_resident = extract_resident(hash[:country])
          c.is_dzo = nil
          c.is_sme = hash[:is_smb]
          c.jsc_form_id = nil
          c.sme_type_id = nil
          c.oktmo = 0

          responce = JSON.parse(
            RestClient.post(
              [Settings.torg_url[:host], "contractors"].join('/'),
                contractor: c.to_h,
                accept: :json,
                content_type: :json,
                format: :json
            ),
            symbolize_names: true
          )
          c.id = responce[:id]
          c
        end

        def extract_ownership(org_name_short)
          org_name_short[/^([\w\-]+)/]
        end

        def extract_form(bank_inn)
          case bank_inn.size
          when 12 then "businessman"
          when 10 then "company"
          else "foreign"
          end
        end

        def extract_resident(country)
          country == 643
        end
      end
    end
  end
end
