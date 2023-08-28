class MessageThreadsController < ApplicationController
  before_action :authenticate_user!
	
	def index
    message_thread_ids = MessageThreadsUser.where(user: current_user).pluck(:message_thread_id)
    @message_threads = MessageThread.includes(:users, :messages).where(id: message_thread_ids).order("messages.created_at desc").to_a
    if params[:user_id].present? && !@message_threads.map(&:users).flatten.map(&:id).flatten.include?(params[:user_id].to_i)
      @user = User.find(params[:user_id])
      @message_threads.unshift(MessageThread.new)
    end
	end
end
