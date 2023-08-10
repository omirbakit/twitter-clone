class MessageThreadsController < ApplicationController
  before_action :authenticate_user!
	
	def index
    message_thread_ids = MessageThreadsUser.where(user: current_user).pluck(:message_thread_id)
    @message_threads = MessageThread.includes(:users, :messages).where(id: message_thread_ids)
    if params[:user_id].present?
      @new_message_thread_user = User.find(params[:user_id])
    end
	end
end
