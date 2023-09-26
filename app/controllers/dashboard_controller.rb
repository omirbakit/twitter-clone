class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet_activities = current_user.tweet_activities.order(created_at: :desc).page(params[:page]).per(10)
    @tweet_activities_data = {
      tweet_activities: @tweet_activities.map do |tweet_activity|
        TweetPresenter.new(tweet: tweet_activity.tweet, current_user: current_user, tweet_activity: tweet_activity)
      end,
      page: @tweet_activities.current_page,
      next_page: @tweet_activities.next_page,
      last_page: @tweet_activities.last_page?,
      total_pages: @tweet_activities.total_pages
    }

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end