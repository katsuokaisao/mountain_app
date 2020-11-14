FactoryBot.define do
  factory :user do
    username {"foobarbazz"}
    sequence(:email) { |n| "foobarbazz#{n}@exapmle.com"}
    password {"foobarbazz"}
  end
end
