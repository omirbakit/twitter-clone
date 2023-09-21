require "rails_helper"

RSpec.describe "ReplyTweets", type: :request do
  let(:user) { create(:user) }
  let(:parent_tweet) { create(:tweet) }

  before { sign_in user }

  describe "POST create" do
    before { parent_tweet }

    it "creates a new tweet" do
      expect do
        post tweet_reply_tweets_path(parent_tweet), params: {
          tweet: {
            body: "New tweet body"
          }
        }
      end.to change { Tweet.count }.by(1)
      expect(response).to redirect_to(dashboard_path)
    end

    it "creates a new TweetActivity" do
      expect do
        post tweet_reply_tweets_path(parent_tweet), params: {
          tweet: {
            body: "New tweet body"
          }
        }
      end.to change { TweetActivity.count }.by(1)
    end
  end
end