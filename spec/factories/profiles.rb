FactoryBot.define do
  factory :profile do
    association :user
    introduce_text { "登山を大学生の時に初めました。現在はお盆休みなどの長期休みに山に登りに行きます。自分の好きな山は鳥海山です。なぜなら大学生の時に大学から近かったこともあり、友達やバイトの先輩などいろいろな人と鳥海山に登っていろいろな経験が詰まっているからです。" }
  end
end
