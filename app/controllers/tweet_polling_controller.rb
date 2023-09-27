class TweetPollingController < ApplicationController
	before_action :authenticate_user!

	def index
		@tweet_activities = current_user.tweet_activities.order(created_at: :desc).where("tweet_id > ?", params[:latest_tweet_id])
		@tweet_activities_data = {
      tweet_activities: @tweet_activities.map do |tweet_activity|
        TweetPresenter.new(tweet: tweet_activity.tweet, current_user: current_user, tweet_activity: tweet_activity)
      end
    }

		respond_to do |format|
			format.turbo_stream
		end
	end
end