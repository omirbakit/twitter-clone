class TweetPollingController < ApplicationController
	before_action :authenticate_user!

	def index
		respond_to do |format|
			format.turbo_stream
		end
	end
end