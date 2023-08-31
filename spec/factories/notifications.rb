FactoryBot.define do
  factory :notification do
    user { nil }
    actor { nil }
    tweet { nil }
    verb { "MyString" }
  end
end
