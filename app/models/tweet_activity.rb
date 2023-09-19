class TweetActivity < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  belongs_to :actor, class_name: "User"

  VERBS = %w[tweeted liked replied retweeted].freeze

  validates :verb, presence: true, inclusion: { in: VERBS }
end
