class TweetActivity < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  VERBS = %w[tweeted liked replied retweeted].freeze

  validates :verb, presence: true, inclusion: { in: VERBS }
end
