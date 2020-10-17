FactoryBot.define do
  factory :daily do
    mountain-name { "MyString" }
    title { "MyString" }
    comment { "MyText" }
    user { nil }
    mountain { nil }
  end
end
