class MessagesController < ApplicationController
	before_action :authenticate_user!

	def create
		user = User.find(params[:user_id])
		user_message_thread_ids = MessageThreadsUser.where(user: user).pluck(:message_thread_id)
		my_message_thread_ids = MessageThreadsUser.where(user: current_user).pluck(:message_thread_id)

		common_message_thread_ids = user_message_thread_ids & my_message_thread_ids
		if common_message_thread_ids.empty?
			ActiveRecord::Base.transaction do
				message_thread = MessageThread.create
				user.message_threads << message_thread
				current_user.message_threads << message_thread
				Message.create(message_params.merge(user: current_user, message_thread: message_thread))
			end
		else
			message_thread = MessageThread.find(common_message_thread_ids.first)
			Message.create(message_params.merge(user: current_user, message_thread: message_thread))
		end
	end
	
	private

	def message_params
		params.require(:message).permit(:body)
	end
end