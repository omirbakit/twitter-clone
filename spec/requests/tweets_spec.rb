require "rails_helper"

RSpec.describe "Tweets", type: :request do
  describe "GET show" do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet) }

    before do
      sign_in user
      allow(ViewTweetJob).to receive(:perform_later)
    end

    it "succeeds" do
      get tweet_path(tweet)
      expect(response).to have_http_status(:success)
    end

    it "queues up ViewedTweetJob" do
      get tweet_path(tweet)
      expect(ViewTweetJob).to have_received(:perform_later).with(user: user, tweet: tweet)
    end
  end

  describe "POST create" do
    context "when not signed in" do
      it "is responds with redirect" do
        post tweets_path, params: {
          tweet: {
            body: "New tweet body"
          }
        }
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when logged in" do
      let(:user) { create(:user) }
      before do
        sign_in user
        allow(TweetActivity::TweetedJob).to receive(:perform_later)
      end

      it "creates a new tweet" do
        expect do
          post tweets_path, params: {
            tweet: {
              body: "New tweet body"
            }
          }
        end.to change { Tweet.count }.by(1)
        expect(response).to redirect_to(dashboard_path)
      end

      it "queues up TweetActivity::TweetedJob" do
        post tweets_path, params: {
          tweet: {
            body: "New tweet body"
          }
        }
        tweet = Tweet.last
        expect(TweetActivity::TweetedJob).to have_received(:perform_later).with(actor: user, tweet: tweet)
      end
    end
  end
end