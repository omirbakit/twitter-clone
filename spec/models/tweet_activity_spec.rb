require "rails_helper"

RSpec.describe TweetActivity, type: :model do
  it { should belong_to :user }
  it { should belong_to :tweet }
  it { should validate_presence_of(:verb) }
  it { should validate_inclusion_of(:verb).in_array(TweetActivity::VERBS) }
end
