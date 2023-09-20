class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet_activities = current_user.tweet_activities.order(created_at: :desc).map do |tweet_activity|
      TweetPresenter.new(tweet: tweet_activity.tweet, current_user: current_user)
    end
  end
end