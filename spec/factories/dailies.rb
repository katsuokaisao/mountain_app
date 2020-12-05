FactoryBot.define do
  factory :daily do
    mountain_name { '富士山' }
    title { '絶景富士山に行ってみた' }
    comment { '道のりがとても険しくて大変だと思ってたけど、道が整備されていてとても楽に登ることができた。朝日はとても綺麗でこれがご来光って言うものかと感嘆した。皆さんにも富士山は是非お勧めしたいです。' }
    association :user
    association :mountain
  end
end
