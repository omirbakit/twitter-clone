FactoryBot.define do
  factory :tweet_activity do
    user
    tweet
    verb { TweetActivity::VERBS.sample }
  end
end
