class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User"
  belongs_to :tweet, optional: true

  VERBS = %w[followed-me liked-tweet mentioned-me].freeze
  validates :verb, presence: true, inclusion: { in: VERBS }
end
