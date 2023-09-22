class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to profile_path if params[:id].to_i == current_user.id
    @user = User.find(params[:id])
    @tweet_presenters = @user.tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet: tweet, current_user: current_user)
    end
  end
end