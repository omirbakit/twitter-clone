FactoryBot.define do
  factory :notification do
    user
    actor { create(:user) }
    tweet
    verb { Notification::VERBS.sample }
  end
end
