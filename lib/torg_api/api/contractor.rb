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

      class << self
        # Поиск id контрагентов по ИНН
        # @param inn [String] ИНН
        # @return [Integer[]] Массив id найденных контрагентов отсортированных по статусу и дате изменения
        def find_by_inn(inn)
          TorgApi::Models::Contractor
            .where(inn: inn)
            .where(next_id: nil)
            .order("#{DECODE_STATUS_ORDER}, updated_at desc")
            .pluck('id')
        end

        # Создаёт контрагента
        # @param hash [Hash] хэш ответа веб-сервиса B2B
        # @param user [Integer] id автора
        # @return [Integer] id созданного объекта
        def create_from_b2b(hash, user)
          c = Contractor.new
          c.name = hash[:org_name_short]
          c.fullname = hash[:org_name]
          c.ownership = extract_ownership(hash[:org_name_short])
          c.inn = hash[:bank_inn]
          c.kpp = hash[:bank_kpp]
          c.ogrn = hash[:ogrn]
          c.okpo = hash[:code_okpo]
          c.status = 0 # enum status: { orig: 0, active: 1, old: 2, inactive: 3 }
          c.form = extract_form(hash[:bank_inn])
          c.legal_addr = hash[:jury_address]
          c.user_id = user
          c.is_resident = extract_resident(hash[:country])
          c.is_dzo = nil
          c.is_sme = hash[:is_smb]
          c.jsc_form_id = nil
          c.sme_type_id = nil

          TorgApi::Models::Contractor.create!(c.to_h).id
        end

        def extract_ownership(org_name_short)
          org_name_short[/^([\w\-]+)/]
        end

        def extract_form(bank_inn)
          # enum form: { businessman: 0, company: 1, foreign: 2, person: 3 }
          case bank_inn.size
          when 12 then 0
          when 10 then 1
          else 2
          end
        end

        def extract_resident(country)
          country == 643
        end
      end
    end
  end
end
