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

# Параметры подключения к БД
TorgApi.establish_connection(
  adapter: 'oracle_enhanced',
  database: 'ksazd_backup',
  username: 'user',
  password: 'pass'
)

# Логгер если нужен
TorgApi.logger = Logger.new('queries.log')

# Пример поиска по ИНН контрагентов
ids = TorgApi::Api::Contractor.find_by_inn('7707083893')
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

contractor_id = TorgApi::Api::Contractor.create_from_b2b(firm_info, 555)
ap contractor_id
```

## Documentation

http://www.rubydoc.info/gems/torg_api

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
