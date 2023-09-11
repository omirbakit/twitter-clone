class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    following_users = current_user.following_users
    @tweets = Tweet.includes(:liked_users, :bookmarked_users, :retweeted_users, :user).where(user: following_users).order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet: tweet, current_user: current_user)
    end
  end
end