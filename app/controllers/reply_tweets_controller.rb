class ReplyTweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reply_tweet = tweet.reply_tweets.create(tweet_params.merge(user: current_user))
    TweetActivity.create(user: current_user, actor: current_user, tweet: tweet, verb: "replied")

    if @reply_tweet.save
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      end
    end
  end

  private

  def tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end