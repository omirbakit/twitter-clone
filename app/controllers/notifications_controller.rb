class  NotificationsController < ApplicationController
  before_action :authenticate_user!

	def index
		@notifications = current_user.notifications.includes(:actor, :tweet)
	end

	def destroy
		@notification = Notification.find(params[:id])
		@notification.destroy
		respond_to do |format|
			format.turbo_stream
		end
	end
end