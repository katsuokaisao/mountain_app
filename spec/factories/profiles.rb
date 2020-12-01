FactoryBot.define do
  factory :profile do
    association :user
    introduce_text { '登山を大学生の時に初めました。現在はお盆休みなどの長期休みに山に登りに行きます。自分の好きな山は鳥海山です。' }
  end
end
