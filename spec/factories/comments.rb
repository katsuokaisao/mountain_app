FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user { nil }
    daily { nil }
  end
end
