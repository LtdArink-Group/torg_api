# TorgApi

API for Torg system

## Installation

Add this line to your application's Gemfile:

    gem 'torg_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install torg_api

## Usage

```ruby
require 'torg_api'
require 'awesome_print'
require 'logger'

# Пердварительная настройка
# Параметры подключения к системе Tender Organizer
TorgApi::Settings.torg_url_configure(host: 'http://login:password@host:port', ssl: { verify_ssl: OpenSSL::SSL::VERIFY_NONE })

# ИД пользователя в системе Tender Organizer, от имени которого будет работать библиотека
TorgApi::Settings.service_user_configure(id: user_id)


# Пример использования

# Пример поиска по ИНН контрагентов
ids = TorgApi::Api::Contractor.find_by_inn('2721124655')
ap ids

# Пример создания контрагента

# хэш ответа веб-сервиса B2B
firm_info = {
  firm_id: '15777',
  date_lastedit: '2006-04-17 16:26:56 +1100',
  org_name: 'Обучение 326',
  org_name_short: 'Обучение 326',
  code_okpo: '47526985',
  bank_name: 'Сбербанк РФ',
  bank_inn: '5836614002',
  ogrn: nil,
  ogrn_given: nil,
  ogrn_date_given: nil,
  bank_kpp: '583601001',
  bank_bik: '045655724',
  bank_r_account: '40702810006000000384',
  bank_c_account: '30101810500000000724',
  bank_comments: 'без комментариев',
  jury_address: 'Нижегородская область, г. Бор',
  post_address: 'Нижегородская область, г. Бор',
  fact_address: 'Нижегородская область, г. Бор',
  site_url: 'www.bsz.ru',
  certification: 'Сертификат мира № 1 от 01.01.01, выдан мировым сообществом',
  org_details: nil,
  bank_details: nil,
  country: 643,
  is_smb: false
}

b2b_hash = {:firm_id=>"277550", :date_lastedit=>nil, :org_name=>"Общество с ограниченной ответственностью \"АГЕНТСТВО ИНТЕЛЛЕКТУАЛЬНОЙ СОБСТВЕННОСТИ \"ИНСО - ЭНЕРГО\"", :org_name_short=>"ООО \"АИС \"ИНСО - ЭНЕРГО\"", :code_okpo=>"51257002", :bank_name=>nil, :bank_inn=>"7728194072", :ogrn=>"1037739581197", :ogrn_given=>nil, :ogrn_date_given=>nil, :bank_kpp=>"772401001", :bank_bik=>nil, :bank_r_account=>nil, :bank_c_account=>nil, :bank_comments=>nil, :jury_address=>"115201, Россия, г. Москва, Каширское ш., д. 22, корп. 3", :post_address=>"115201, Россия, г. Москва, Каширское ш., д. 22, корп. 3", :fact_address=>"115201, Россия, г. Москва, Каширское ш., д. 22, корп. 3", :site_url=>nil, :certification=>nil, :org_details=>nil, :bank_details=>nil, :country=>643, :is_smb=>false}

# c = TorgApi::Api::Contractor.create_from_b2b(b2b_hash)
ap с
```

## Documentation

http://www.rubydoc.info/gems/torg_api

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
